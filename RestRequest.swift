//
//  ServerRequest.swift
//  HSP
//
//  Created by Keyur Ashra on 03/04/17.
//  Copyright © 2017 Riontech. All rights reserved.
//

import Alamofire

class RestRequest: NSObject {
    
    static let CONTENT_TYPE_VALUE = "application/json"
    static let CONTENT_TYPE_KEY = "Content-Type"
    
    static func getGetRequest(_ url: String) -> DataRequest{
        let fullUrl = mainURL + url
        let headers: HTTPHeaders = [CONTENT_TYPE_KEY: CONTENT_TYPE_VALUE]
        return  NetworkManager.request(fullUrl, method: .get, headers: headers)
    }
    
    static func getPostRequest(_ url: String,_ parameters: Parameters) -> DataRequest{
        let fullUrl = mainURL + url
        let headers: HTTPHeaders = [CONTENT_TYPE_KEY: CONTENT_TYPE_VALUE]
        return NetworkManager.request(fullUrl, method: .post, headers: headers, parameters: parameters)
    }
    
    static func getDeleteRequest(_ parameters: Parameters) -> DataRequest{
        let headers: HTTPHeaders = [CONTENT_TYPE_KEY: CONTENT_TYPE_VALUE]
        return NetworkManager.request(mainURL, method: .delete, headers: headers, parameters: parameters)
    }
    
    static func getPutRequest(_ parameters: Parameters) -> DataRequest{
        let headers: HTTPHeaders = [CONTENT_TYPE_KEY: CONTENT_TYPE_VALUE]
        return NetworkManager.request(mainURL, method: .put, headers: headers, parameters: parameters)
    }
    
//    static func authenticateGetRequest(_ url: String) -> DataRequest{
//        let fullUrl = mainURL + url
//        let headers: HTTPHeaders = [CONTENT_TYPE_KEY: CONTENT_TYPE_VALUE,
//                                    ACCESS_TOKEN_KEY : Utility.getXAccessToken()]
//        return  NetworkManager.request(fullUrl, method: .get, headers: headers)
//    }
//    
//    
//    static func authenticatePostRequest(_ parameters: Parameters) -> DataRequest{
//        let fullUrl = mainURL + url
//        let headers: HTTPHeaders = [CONTENT_TYPE_KEY: CONTENT_TYPE_VALUE,
//                                    ACCESS_TOKEN_KEY : Utility.getXAccessToken()]
//        return NetworkManager.request(fullUrl, method: .post, headers: headers, parameters: parameters)
//    }
//    
//    static func authenticateDeleteRequest(_ parameters: Parameters) -> DataRequest{
//        let fullUrl = mainURL + url
//        let headers: HTTPHeaders = [CONTENT_TYPE_KEY: CONTENT_TYPE_VALUE,
//                                    ACCESS_TOKEN_KEY : Utility.getXAccessToken()]
//        return NetworkManager.request(fullUrl, method: .delete, headers: headers, parameters: parameters)
//        
//    }
//    
//    static func authenticatePutRequest(_ parameters: Parameters) -> DataRequest{
//        let fullUrl = mainURL + url
//        let headers: HTTPHeaders = [CONTENT_TYPE_KEY: CONTENT_TYPE_VALUE,
//                                    ACCESS_TOKEN_KEY : Utility.getXAccessToken()]
//        return NetworkManager.request(fullUrl, method: .put, headers: headers, parameters: parameters)
//    }
//    
//    static func authenticatePatchRequest(_ parameters: Parameters) -> DataRequest{
//        let fullUrl = mainURL + url
//        let headers: HTTPHeaders = [CONTENT_TYPE_KEY: CONTENT_TYPE_VALUE,
//                                    ACCESS_TOKEN_KEY : Utility.getXAccessToken()]
//        return NetworkManager.request(fullUrl, method: .patch, headers: headers, parameters: parameters)
//    }
    
}
