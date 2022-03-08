//
//  String+N.swift
//  KingNetSDK
//
//  Created by admin on 2020/11/23.
//  Copyright © 2020 niujf. All rights reserved.
//
import CommonCrypto
import Foundation

extension String: NCompatoble {}
extension NSString: NCompatoble {}

extension N where Base: ExpressibleByStringLiteral {
    var md5: String {
         guard let str = base as? String else { return "" }
         let utf8 = str.cString(using: .utf8)
         var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
         CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
         let upper:String = digest.reduce("") { $0 + String(format:"%02X", $1) }
         return upper.lowercased()
      }
    
    var date: String {
        guard let str = base as? NSString else { return "" }
        let timeSta: TimeInterval = str.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy年MM月dd日 HH:mm:ss"
        let date = NSDate(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date as Date)
    }
    
    var encode: String {
        guard let str = base as? String else { return "" }
        let encodeUrlString = str.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
}
