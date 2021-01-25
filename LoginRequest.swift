//
//  UserPredictionRequest.swift
//  FPA
//
//  Created by Keyur Ashra on 08/12/17.
//  Copyright © 2017 Riontech. All rights reserved.
//

import Foundation
import ObjectMapper

class UserPredictionRequest: Mappable {
    var leagueId : String?
    var teamId : String?
    var teamName : String?
    var userPosition : String?
    var actualPosition : String?
    var pointsEarned : String?
    
    required init?(map: Map) {}
    init(){}
    
    func mapping(map: Map) {
        leagueId <- map["leagueId"]
        teamId <- map["teamId"]
        teamName <- map["teamName"]
        userPosition <- map["userPosition"]
        actualPosition <- map["actualPosition"]
        pointsEarned <- map["pointsEarned"]
    }
}
