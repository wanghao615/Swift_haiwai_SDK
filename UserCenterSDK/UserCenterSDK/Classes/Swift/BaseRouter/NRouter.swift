//
//  NRouter.swift
//  RouterTest
//
//  Created by admin on 2021/1/28.
//  Copyright © 2021 niujf. All rights reserved.
//

let N_ROUTER_WILDCARD_CHARACTER = "~"
let specialCharacters = "/?&."
public let NRouterParameterURL = "NRouterParameterURL"
public let NRouterParameterInfo = "NRouterParameterInfo"

import UIKit

public typealias routerHandler = (_ parameters: [String: Any]?) -> Void

class NRouter {
    static let share = NRouter()
    lazy var routes = NSMutableDictionary()
}

//MARK: - 注册url
extension NRouter {
    class func registerUrlWithHandler(urlPattern: String, handler: routerHandler?) {
        share.addUrlWithHandler(urlPattern, handler)
    }
    
    private func addUrlWithHandler(_ urlPattern: String, _ handler: routerHandler?) {
        let subRoutes = addUrl(urlPattern)
        if handler != nil {
            subRoutes?["_"] = handler
        }
    }
    
    private func addUrl(_ urlPattern: String) -> NSMutableDictionary? {
        guard let pathComponents = pathComponentsFromURL(urlPattern) else {
            return nil
        }
        var subRoutes = routes
        
        for pathComponent in pathComponents {
            if subRoutes[pathComponent] == nil {
                subRoutes[pathComponent] = NSMutableDictionary()
            }
            if let subRoute = subRoutes[pathComponent] as? NSMutableDictionary {
                subRoutes = subRoute
            }
        }
        return subRoutes
    }
}

//MARK: - 取消注册url
extension NRouter {
    class func deregisterURL(urlPattern: String) {
        share.removeURLPattern(urlPattern)
    }
    
    private func removeURLPattern(_ urlPattern: String) {
        guard var pathComponents = pathComponentsFromURL(urlPattern) else { return }
        // 只删除该 pattern 的最后一级
        if pathComponents.count >= 1 {
            // 假如 URLPattern 为 a/b/c, components 就是 @"a.b.c" 正好可以作为 KVC 的 key
            let components = pathComponents.joined(separator: ".")
            guard var route = routes.value(forKeyPath: components) as? NSMutableDictionary else { return }
            if route.count >= 1 {
                let lastComponent = pathComponents.last ?? ""
                pathComponents.removeLast()
                // 有可能是根 key，这样就是 routes 了
                route = routes
                if pathComponents.count > 0 {
                    let componentsWithoutLast = pathComponents.joined(separator: ".")
                    route = routes.value(forKeyPath: componentsWithoutLast) as! NSMutableDictionary
                }
                route.removeObject(forKey: lastComponent)
            }
        }
    }
}

//MARK: - open url
extension NRouter {
    class func openUrl(url: String) {
        openUrl(url: url, completion: nil)
    }
    
    class func openUrl(url: String, completion: ((Bool)->())?) {
        openUrl(url: url, parameter: nil, completion: completion)
    }
    
    class func openUrl(url: String, parameter: [String: Any]?, completion: ((Bool)->())?){
        guard let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        if let parameters = share.extractParametersFromURL(urlString, false) {
            for (key, value) in parameters {
                if Mirror(reflecting: value).subjectType is NSString.Type {
                    parameters[key] = (value as! NSString).removingPercentEncoding
                }
             }
            if parameters.count > 0 {
                if completion != nil {
                    completion!(true)
                }
                if parameter != nil {
                    parameters[NRouterParameterInfo] = parameter
                }
                let handler = parameters["block"] as? routerHandler
                if handler != nil {
                    parameters.removeObject(forKey: "block")
                    handler!(parameters as? [String : Any])
                }
            }
        }else {
            if completion != nil {
                completion!(false)
            }
        }
    }
    
    private func extractParametersFromURL(_ url: String, _ matchExactly: Bool) -> NSMutableDictionary? {
        let parameters = NSMutableDictionary()
        parameters[NRouterParameterURL] = url
        var subRoutes = routes
        guard let pathComponents = pathComponentsFromURL(url) else { return nil}
        
        var found = false
        for pathComponent in pathComponents {
            // 对 key 进行排序，这样可以把 ~ 放到最后
            let subRoutesKeys = subRoutes.allKeys.sorted { ($0 as! String) > ($1 as! String)
            }
            for key in subRoutesKeys as! [String]{
                if key == pathComponent || key == N_ROUTER_WILDCARD_CHARACTER {
                    found = true
                    subRoutes = subRoutes[key] as! NSMutableDictionary
                    break
                }else if key.hasPrefix(":") {
                    found = true
                    subRoutes = subRoutes[key] as! NSMutableDictionary
                    var newKey = (key as NSString).substring(from: 1)
                    var newPathComponent = pathComponent
                    // 再做一下特殊处理，比如 :id.html -> :id
                    if checkIfContainsSpecialCharacter(key) {
                        let specialCharacterSet = CharacterSet.init(charactersIn: specialCharacters)
                        guard let rangeC = key.rangeOfCharacter(from: specialCharacterSet) else {
                            return nil
                        }
                        let range = NSRange(rangeC, in: key)
                        if range.location != NSNotFound {
                            // 把 pathComponent 后面的部分也去掉
                            newKey = (newKey as NSString).substring(to: range.location - 1)
                            let suffixToStrip = (key as NSString).substring(from: range.location)
                            newPathComponent = (newPathComponent as NSString).replacingOccurrences(of: suffixToStrip, with: "")
                        }
                    }
                    parameters[newKey] = newPathComponent
                    break
                }else if matchExactly {
                    found = false
                }
            }
            // 如果没有找到该 pathComponent 对应的 handler，则以上一层的 handler 作为 fallback
            if !found && (subRoutes["_"] == nil) {
                return nil
            }
        }
        // Extract Params From Query.
        if let queryItems = URLComponents(url: URL(string: url)!, resolvingAgainstBaseURL: false)?.queryItems {
            for item in queryItems {
                   parameters[item.name] = item.value
            }
        }
        
        if (subRoutes["_"] != nil) {
            parameters["block"] = subRoutes["_"]
        }
        return parameters;
    }
    
    private func checkIfContainsSpecialCharacter(_ checkedString: String) -> Bool {
        let specialCharactersSet = CharacterSet.init(charactersIn: checkedString)
        guard let range = checkedString.rangeOfCharacter(from: specialCharactersSet) else {
            return false
        }
        return NSRange(range, in: checkedString).location != NSNotFound
    }
}

//MARK: - 是否可以打开url
extension NRouter {
    class func canOpenUrl(url: String) -> Bool {
        return share.extractParametersFromURL(url, false) != nil
    }
    
    class func canOpenUrl(url: String, matchExactly: Bool) -> Bool {
        return share.extractParametersFromURL(url, true) != nil
    }
}

//MARK: - 拆分url
extension NRouter {
    private func pathComponentsFromURL(_ url: String) -> [String]? {
        var oUrl = url as NSString
        var pathComponents: [String] = []
        if oUrl.range(of: "://").location != NSNotFound {
            let pathSegments = oUrl.components(separatedBy: "://")
            // 如果 URL 包含协议，那么把协议作为第一个元素放进去
            pathComponents.append(pathSegments[0])
            // 如果只有协议，那么放一个占位符
            oUrl = pathSegments.last as NSString? ?? ""
            if oUrl.length == 0 {
                pathComponents.append(N_ROUTER_WILDCARD_CHARACTER)
            }
        }
        
        let urlString = oUrl as String
        guard let pathComponentArr = URL(string: urlString)?.pathComponents else {
            return pathComponents
        }
        
        for pathComponent in pathComponentArr {
            if pathComponent == "/" { continue }
            if (pathComponent as NSString).substring(to: 1) == "?" { break }
            pathComponents.append(pathComponent)
        }
        return pathComponents
    }
}


