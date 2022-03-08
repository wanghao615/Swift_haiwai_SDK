//
//  IAPTool.swift
//  KingNetSDK
//
//  Created by admin on 2021/1/4.
//  Copyright © 2021 niujf. All rights reserved.
//
import StoreKit

class IAPTool: NSObject {
    
    static let share = IAPTool()
    var productId: String?
    var skProduct: SKProduct?
    var skProductCallback: (() -> ())?
    var skProductfailed: ((String) -> ())?
    var skOrderCallback: ((String, String, String) -> ())?
    var skPurchasedCancelCallback: ((String, String) -> ())?
    var removeProgressCallback: (() -> ())?
    
    deinit {
        print("\(self) 释放了")
        SKPaymentQueue.default().remove(self)
    }
}

extension IAPTool {
    func addPayment() {
        if let skProduct = skProduct {
            let payment = SKPayment(product: skProduct)
            SKPaymentQueue.default().add(payment)
        }
    }
    
    private func removeAllUncompleteTransactionsBeforeNewPurchase() {
        let transactions = SKPaymentQueue.default().transactions
        if transactions.count > 0 {
            var count = transactions.count
            while count > 0 {
                count -= 1
                let transaction: SKPaymentTransaction = transactions[count]
                if transaction.transactionState == .purchased || transaction.transactionState == .restored {
                    SKPaymentQueue.default().finishTransaction(transaction)
                }
            }
        }else {
            debugPrint("没有历史未消耗订单")
        }
    }
}

extension IAPTool: SKPaymentTransactionObserver {
    func requestWithProductId(_ productId: String, skProductCallback: @escaping () -> (),skProductfailed: @escaping (String) -> ()) {
        
        self.skProductfailed = skProductfailed
        if productId.count <= 0 {
            debugPrint("productId为空")
            if (self.skProductfailed != nil) {
                self.skProductfailed!("productId为空")
            }
            return
        }
        if SKPaymentQueue.canMakePayments() {//允许内购
            //清除历史订单
            removeAllUncompleteTransactionsBeforeNewPurchase()
            
            self.productId = productId
            self.skProductCallback = skProductCallback
            //监听购买状态
            SKPaymentQueue.default().add(self)
            //苹果后台查询商品id
            var set = Set<String>()
            set.insert(productId)
            let request = SKProductsRequest(productIdentifiers: set)
            request.delegate = self;
            request.start()
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for tran in transactions {
            switch tran.transactionState {
            case .purchased:
                print("购买成功")
                if let receiptURL: URL = Bundle.main.appStoreReceiptURL {
                    // 从沙盒中获取到购买凭据
                    do {
                        let receiptData: Data = try Data.init(contentsOf: receiptURL)
                        let base64S = receiptData.base64EncodedString(options: .endLineWithLineFeed)
                        if skOrderCallback != nil {
                            skOrderCallback! (base64S, tran.transactionIdentifier ?? "", tran.payment.productIdentifier)
                        }
                    } catch  {
                        
                    }
                }
                SKPaymentQueue.default().finishTransaction(tran)
            case .failed:
                debugPrint("购买失败")
                let price = tran.payment.productIdentifier.components(separatedBy: ".").last ?? ""
                if skPurchasedCancelCallback != nil { skPurchasedCancelCallback! (tran.payment.productIdentifier, price) }
                SKPaymentQueue.default().finishTransaction(tran)
            case .restored:
                debugPrint("已经购买过商品")
                if removeProgressCallback != nil { removeProgressCallback! () }
                SKPaymentQueue.default().finishTransaction(tran)
            case .purchasing:
                debugPrint("购买中")
            case .deferred:
                if removeProgressCallback != nil { removeProgressCallback! () }
                debugPrint("状态未确定")
            default:
                if removeProgressCallback != nil { removeProgressCallback! () }
                break
            }
        }
    }
}

extension IAPTool: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let product = response.products;
        if product.count == 0 {
            debugPrint("查找不到商品信息")
            if (self.skProductfailed != nil) {
                self.skProductfailed!(SDK.R.string.iap_NoProduct)
            }
            return
        }
        for pro in product {
            print(pro.description)
            print(pro.localizedTitle)
            print(pro.localizedDescription)
            print(pro.price)
            print(pro.productIdentifier)
            if self.productId == pro.productIdentifier {//获取到商品信息
                self.skProduct = pro
            }
            //回调
            if skProductCallback != nil { skProductCallback! () }
        }
    }
}

