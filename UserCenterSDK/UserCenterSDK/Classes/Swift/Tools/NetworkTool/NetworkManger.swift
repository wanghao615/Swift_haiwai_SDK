//
//  NetworkManger.swift
//  SwiftDemo
//
//  Created by niujf on 2019/4/28.
//  Copyright © 2019 niujf. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import class OCModule.BridgeManger

/// 超时时长
private var requestTimeOut: Double = 15
///成功数据的回调
typealias successCallback = ((Any) -> (Void))
///失败的回调
typealias failedCallback = ((String) -> (Void))

/// endpointClosure用来构建Endpoint
private let myEndpointClosure = { (target: TargetType) -> Endpoint in
    let url = target.baseURL.absoluteString + target.path
    var task = target.task
    var method = target.method
    if url.contains(User_BaseUrl) {
        /*
        参数统一处理
        👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
        */
        switch target.task {
        case .requestParameters(var parameters, let encoding):
            print("公共参数前\(parameters)")
            ///添加全局参数
            let danaIdfa: String = BridgeManger.getIdfa()
            let dana_v2 = "appid=\(SDK.appid)&bundle_name=\(String(describing: KAppName))&bundle_id=\(KAPPBundleIdentifier)&did=\(String(describing: danaIdfa))&idfa=\(String(describing: danaIdfa))&terminal=iOS&openid=\("")"
            let adid: String = AdjustService.adjustAdid
            let idfa: String = AdjustService.adjustIdfa
            let _adjust = "appid=\(SDK.appid)&adid=\(adid)&gps_adid=\("")&idfa=\(idfa)"
            parameters["_dana_v2"] = dana_v2
            parameters["_adjust"] = _adjust
            print("公共参数后\(parameters)")
            let query = appendPara(parameters)
            let query_key = String(format: "%@%@", Para_Key,query)
            let md5S = query_key.n.md5
            parameters["sign"] = md5S
            if method == .post {//post请求参数额外加密
                if let para = encryptionWithPara(parameters) {
                    parameters = para
                }
            }
            task = .requestParameters(parameters: parameters, encoding: encoding)
        default:
            break
        }
        /*
        👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆
        参数统一处理
        */
    }else {
        requestTimeOut = 60 //按照项目需求针对单个API设置不同的超时时长
    }
    var endpoint = Endpoint(
        url: url,
        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
        method: target.method,
        task: task,
        httpHeaderFields: target.headers
    )
    return endpoint
}

///网络请求的设置
private let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        //设置请求时长
        request.timeoutInterval = requestTimeOut
        // 打印请求参数
        if let requestData = request.httpBody {
            debugPrint("""
                    \(request.url!)"
                    "\(request.httpMethod ?? "")"
                    "请求头\(request.headers)"
                    "发送参数:"\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")
                    """)
        }else{
            debugPrint("\(request.url!)"+"\(String(describing: request.httpMethod))")
        }
        done(.success(request))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}

/// NetworkActivityPlugin插件用来监听网络请求
private let networkPlugin = NetworkActivityPlugin.init { (changeType, targetType) in
    debugPrint("networkPlugin \(changeType)")
    //targetType 是当前请求的基本信息
    switch(changeType){
    case .began:
        print("开始请求网络")
    case .ended:
        print("结束")
    }
}

////网络请求发送的核心初始化方法，创建网络请求对象
let Provider = MoyaProvider<MultiTarget>(endpointClosure: myEndpointClosure, requestClosure: requestClosure, plugins: [networkPlugin], trackInflights: false)

/// 最常用的网络请求，只需知道正确的结果无需其他操作时候用这个 (可以给调用的NetWorkReques方法的写参数默认值达到一样的效果,这里为解释方便做抽出来二次封装)
///
/// - Parameters:
///   - target: 网络请求
///   - completion: 请求成功的回调
func NetWorkRequest(_ target: TargetType, completion: @escaping successCallback) {
    NetworkRequest(target, completion: completion, failed: nil)
}

@discardableResult // 当我们需要主动取消网络请求的时候可以用返回值Cancellable, 一般不用的话做忽略处理
func NetworkRequest(_ target: TargetType, completion: @escaping successCallback, failed: failedCallback?) ->Cancellable?{
    Provider.request(MultiTarget(target)) { (result) in
        switch result {
        case let .success(response):
            do {
                //转JSON
                let jsonData = try JSON(data: response.data)
                if jsonData["msg"] == "success" || jsonData["msg"] == "CreateOrderSuccess" || jsonData["msg"] == "PaySuccess" {//返回请求的数据
                    completion(jsonData["data"])
                }else{
                    failed?(jsonData["msg"].string ?? "")
                }
            } catch {
                failed?("状态码: \(response.statusCode)")
            }
        case let .failure(error):
             failed?(error.localizedDescription)
        }
    }
}

///参数拼接处理
private func appendPara(_ param: [String: Any]) -> String {
    var arr: [String] = []
    let sortedKeys = Array(param.keys).sorted(by: <)
    for key in sortedKeys {
    let value = BridgeManger.encode((param[key] as? String ?? "")).replacingOccurrences(of: "%20", with: "+")
    let str = String(format: "\(key)=%@",value)
        arr.append(str)
    }
    let query:String = arr.joined(separator: "&")
    return query
}

private func encryptionWithPara(_ param: [String: Any]) -> [String: Any]? {
    ///获取当前时间戳
    let dateStr: String = String(format: "%ld", Int(Date().timeIntervalSince1970))
    let keys: String = XXTEA_Key + dateStr
    let md5Key = keys.n.md5
    let paramStr: String = appendPara(param)
    let o: String = BridgeManger.encryptString(toBase64String: paramStr, stringKey: md5Key)
    let safeStr: String = String(format: "o=%@&t=%@", o,dateStr)
    if safeStr.isEmpty { return nil }
    var dict: [String: Any] = [:]
    for param in safeStr.components(separatedBy: "&") {
        let arr: [String] = param.componentsSeparatedByString("=", 1)
        if arr.count == 2 {
            dict[arr[0].replacingOccurrences(of: " ", with: "")] = arr[1].replacingOccurrences(of: " ", with: "")
        }
    }
    return dict
}

extension String {
    func componentsSeparatedByString(_ separator: String, _ limit: Int) -> [String] {
        if limit == 0 { return components(separatedBy: separator) }
        let allComponents = components(separatedBy: separator)
        var components: [String] = []
        var i: Int = 0
        for str in allComponents {
            if i >= limit {
                components.append(allComponents[i...allComponents.count - 1].joined(separator: separator))
                break
            }
            components.append(str)
            i += 1
        }
        return components
    }
}


