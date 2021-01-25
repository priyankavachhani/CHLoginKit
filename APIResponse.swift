//
//  APIResponse.swift
//  Gridle
//
//  Created by Bhavik Bansal on 11/15/16.
//  Copyright © 2016 Bhavik Bansal. All rights reserved.
//

import Foundation
import ObjectMapper


class APIResponse<T: Mappable> : Mappable{
    var success: String?
    var error: String?
    var errorDescription: String?
    var status: Int?
    var message: String?
    var results: T?
    
    
    required init?(map: Map) {}
    init(){}
    
    func mapping(map: Map) {
        success <- map["success"]
        error <- map["errorInfo"]
        errorDescription <- map["error_description"]
        status <- map["status"]
        message <- map["message"]
        results <- map["result"]
    }
}

class APIArrayResponse<T: Mappable> : Mappable{
    var success: String?
    var error: String?
    var errorDescription: String?
    var status: Int?
    var message: String?
    var results: [T]?
    
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        success <- map["success"]
        error <- map["errorInfo"]
        errorDescription <- map["error_description"]
        status <- map["status"]
        message <- map["message"]
        results <- map["result"]
        
    }
}

class ApiResponse : Mappable{
    var success: String?
    var error: String?
    var errorDescription: String?
    var status: Int?
    var message: String?
    var count: Int?
    var unseenNotification: Int?
    
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        success <- map["success"]
        error <- map["errorInfo"]
        errorDescription <- map["error_description"]
        status <- map["status"]
        message <- map["message"]
        message <- map["success_message"]
        count <- map["count"]
        unseenNotification <- map["unseen_notification"]
        
    }
}

