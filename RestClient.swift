//
//  RestClient.swift
//  HSP
//
//  Created by Admin on 20/06/17.
//  Copyright © 2017 Riontech. All rights reserved.
//

import Foundation
import Alamofire


class RestClient {
    
    //MARK: Login Module
    //Social Signup
      static func signUpSocialRequest(_ request: LoginRequest) -> DataRequest {
        print("PARAMETER_SOCIAL_SIGNUP = \(request.toJSON())")
        return RestRequest.getPostRequest("/index.php/api/users/login", request.toJSON())
    }
    
    //Login Admin
    static func loginAdminRequest(_ request: LoginRequest) -> DataRequest {
        print("PARAMETER_ADMIN = \(request.toJSON())")
        return RestRequest.getPostRequest("/index.php/api/users/adminLogin", request.toJSON())
    }
    
    //Verify OTP
    static func verifyOTPRequest(_ request: LoginRequest) -> DataRequest {
        print("PARAMETER_SOCIAL_SIGNUP = \(request.toJSON())")
        return RestRequest.getPostRequest("/index.php/api/users/verifyOTP", request.toJSON())
    }
    
    //Create Profile
    static func createProfileRequest(_ request: LoginRequest) -> DataRequest {
        print("PARAMETER_CREATE_PROFILE = \(request.toJSON())")
        return RestRequest.getPostRequest("/index.php/api/users/createProfile", request.toJSON())
    }
   
    //Create League
    static func createLeagueRequest(_ request: LeagueRequest) -> DataRequest {
        print("PARAMETER_CREATE_LEAGUE = \(request.toJSON())")
        return RestRequest.getPostRequest("/index.php/api/league/createLeague", request.toJSON())
    }
    
    //GET TEAM
    static func getTeamRequest(_ request: LeagueRequest) -> DataRequest {
        print("SAVE_PREDICTION = \(request.toJSON())")
        return RestRequest.getPostRequest("/index.php/api/users/getTeams", request.toJSON())
    }

    //League Get Teams
    static func leagueGetTeamsRequest(_ request: GetTeamRequest) -> DataRequest {
        print("PARAMETER_LEAGUE_GET_TEAMS = \(request.toJSON())")
        return RestRequest.getPostRequest("/index.php/api/league/getTeams", request.toJSON())
    }
  
    
    //Get League By Country
    static func getLeagueByCountry(_ request: LeagueRequest) -> DataRequest {
        print("GET_LEAGUE = \(request.toJSON())")
        return RestRequest.getPostRequest("/index.php/api/league/leagueByCountryId", request.toJSON())
    }
    
    //Get Team By League Id
    static func getTeamByLeagueIdRequest(_ request: LeagueRequest) -> DataRequest {
        print("PARAMETER_GET_TEAM_BY_LEAGUE_ID = \(request.toJSON())")
        return RestRequest.getPostRequest("/index.php/api/league/getTeamsByLeagueId", request.toJSON())
    }
    
    
    //Get Prediction
    static func getPredictionRequest(_ request: LeagueRequest) -> DataRequest {
        print("GET PREDICTION = \(request.toJSON())")
        return RestRequest.getPostRequest("/index.php/api/prediction/getPredictions", request.toJSON())
    }
    
    
    
    //Save Prediction
    static func savePredictionRequest(_ request: LeagueRequest) -> DataRequest {
        print("SAVE_PREDICTION = \(request.toJSON())")
        return RestRequest.getPostRequest("/index.php/api/prediction/savePrediction", request.toJSON())
    }
    
    //Create Group
    static func createGroupRequest(_ request: LeagueRequest) -> DataRequest {
        print("CREATE_GROUP = \(request.toJSON())")
        return RestRequest.getPostRequest("/index.php/api/users/createGroup", request.toJSON())
    }
    
    //SELECT TEAM
    static func selectTeamRequest(_ request: ServerRequest) -> DataRequest {
        print("SELECTED TEAM = \(request.toJSON())")
        return RestRequest.getPostRequest("/index.php/api/users/selectTeams", request.toJSON())
    }

    
    //Get Leagues
    static func getLeagues() -> DataRequest {
        return RestRequest.getGetRequest("/index.php/api/league/league")
    }
    
    //Get Countries
    static func getCountries() -> DataRequest {
        return RestRequest.getGetRequest("/index.php/api/league/countries")
    }
    
    //Get User
    static func getUsers() -> DataRequest {
        return RestRequest.getGetRequest("/index.php/api/users/getUsers")
    }
    
    //Compare Predictions
    static func comparePredictionsRequest(_ request: LeagueRequest) -> DataRequest {
        print("PARAMETER_COMPARE_PREDICTIONS = \(request.toJSON())")
        return RestRequest.getPostRequest("/index.php/api/prediction/comparePredictions", request.toJSON())
    }
    
    //Assign Leagues
    static func assignLeaguesRequest(_ request: SelectedLeagueRequest) -> DataRequest {
        print("PARAMETER_ASSIGN_LEAGUES = \(request.toJSON())")
        return RestRequest.getPostRequest("/index.php/api/league/selectLeague", request.toJSON())
    }
    
    //GET USER HOME LEAGUES
    static func getUserHomeLeagueRequest(_ request: ServerRequest) -> DataRequest {
        print("PARAMETER_GET_USER_HOME_LEAGUES = \(request.toJSON())")
        return RestRequest.getPostRequest("/index.php/api/league/getUserHomeLeagues", request.toJSON())
    }
    
    /*
    static func loginRequest(_ memberId: String, _ password: String, _ gcmId: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "login"
        let deviceUUID: String = (UIDevice.current.identifierForVendor?.uuidString)!
        serverRequest.username = memberId
//        serverRequest.password = password
        //serverRequest.gcmId = PrefrenceUtils.getFcmToken()
        serverRequest.imei = deviceUUID
        serverRequest.deviceType = "iOS"
        //AppLog.debug(tag: "REST_CLIENT", msg: "LoginRequest: \(serverRequest!.toJSONString(prettyPrint: true)!)")
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    //Get User Request
    static func getUser(_ memberType1: String, _ memberType2: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "get_user"
        serverRequest.memberType1 = memberType1
        serverRequest.memberType2 = memberType2
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func getAllMember() -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "get_all_members"
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    
    //Change Password Request
    static func changePassword(_ oldPassword: String, _ newPassword: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "change_password"
        //serverRequest.username = PrefrenceUtils.getUserName()
        serverRequest.password = oldPassword
        serverRequest.newPassword = newPassword
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    //Delete User Request
    static func deleteUser(_ userId: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "delete_user"
        serverRequest.userId = userId
        AppLog.debug(tag: "PARAM_MEMBER_BRAND", msg: "\(serverRequest.toJSON())")
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func changeUserStatus(_ userId: String, _ status: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "change_user_status"
        serverRequest.userId = userId
        serverRequest.status = status
        AppLog.debug(tag: "PARAM_MEMBER_BRAND", msg: "\(serverRequest.toJSON())")
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    //First Login Request
    static func firstLoginRequest(_ userId: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "first_login"
        serverRequest.id = userId
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }

    //MARK: Brand Request
    static func getAllBrands() -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "get_all_brands"
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func getSingleBrand(_ brandId: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "get_brand"
        serverRequest.brandId = brandId
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func getMemberBrand(_ memberId: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "get_member_brands"
        serverRequest.memberId = memberId
        AppLog.debug(tag: "PARAM_MEMBER_BRAND", msg: "\(serverRequest.toJSON())")
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func getBrandByStock() -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "get_brands_by_stock"
        //serverRequest.id = PrefrenceUtils.getUserId()
        AppLog.debug(tag: "PARAM_BRAND_BY_STOCK", msg: "\(serverRequest.toJSON())")
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }

    
    static func createBrand(_ brandName: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "create_brand"
        serverRequest.brandName = brandName
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func updateBrand(_ brandId: String, _ brandName: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "update_brand"
        serverRequest.brandId = brandId
        serverRequest.brandName = brandName
        AppLog.debug(tag: "PARAM_UPDATE_BRAND", msg: "\(serverRequest.toJSON())")
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func deleteBrand(_ brandId: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "delete_brand"
        serverRequest.brandId = brandId
        AppLog.debug(tag: "PARAM_DELETE_BRAND", msg: "\(serverRequest.toJSON())")
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    //MARK: Model Request
    static func createModel(_ brandId: String,_ modelName: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "create_model"
        serverRequest.brandId = brandId
        serverRequest.modelName = modelName
        AppLog.debug(tag: "PARAM_CREATE_MODEL", msg: "\(serverRequest.toJSON())")
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func updateModel(_ brandId: String,_ modelId: String, _ modelName: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "update_model"
        serverRequest.brandId = brandId
        serverRequest.modelName = modelName
        serverRequest.modelId = modelId
        AppLog.debug(tag: "PARAM_UPDATE_MODEL", msg: "\(serverRequest.toJSON())")
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func getModel(_ brandId: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "get_model"
        serverRequest.brandId = brandId
        AppLog.debug(tag: "PARAM_GET_MODEL", msg: "\(serverRequest.toJSON())")
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func deleteModel(_ brandId: String,_ modelId: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "delete_model"
        serverRequest.brandId = brandId
        serverRequest.modelId = modelId
        AppLog.debug(tag: "PARAM_DELETE_MODEL", msg: "\(serverRequest.toJSON())")
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func getModelByStock(_ brandId: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "get_models_by_stock"
        //serverRequest.id = PrefrenceUtils.getUserId()
        serverRequest.brandId = brandId
        AppLog.debug(tag: "PARAM_MODEL_BY_STOCK", msg: "\(serverRequest.toJSON())")
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }

    
    //MARK: Controller
    static func getControllerHistory(_ userId: String, _ limit: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "controller_history"
        serverRequest.memberId = userId
        serverRequest.limit = limit
        AppLog.debug(tag: "PARAM_controller_history", msg: "\(serverRequest.toJSON())")
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func getControllerHistoryDetails(_ orderId: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "controller_history_details"
        serverRequest.orderId = orderId
        AppLog.debug(tag: "PARAM_controller_history_details", msg: "\(serverRequest.toJSON())")
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    //MARK: AssignQRCode
    static func getLastRange(_ vltId: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "get_last_range"
        serverRequest.vlt = vltId
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func getVLT() -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "get_vlt"
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    //MARK: IMPORTER
    static func getImporterSentHistory(_ userId: String, _ limit: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "importer_sent_history"
        serverRequest.memberId = userId
        serverRequest.limit = limit
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func getImporterSentHistoryDetails(_ orderId: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "importer_sent_history_details"
        serverRequest.orderId = orderId
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func getImporterReceiveHistory(_ userId: String, _ limit: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "importer_receive_history"
        serverRequest.memberId = userId
        serverRequest.limit = limit
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func getImporterReceiveHistoryDetails(_ orderId: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "importer_receive_history_details"
        serverRequest.orderId = orderId
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    //MARK: RETAILER
    static func getRetailerReceiveHistory(_ userId: String, _ limit: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "retailer_receive_history"
        serverRequest.memberId = userId
        serverRequest.limit = limit
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func getRetailerReceiveHistoryDetails(_ orderId: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "retailer_receive_history_details"
        serverRequest.orderId = orderId
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func getRetailerSentHistory(_ userId: String, _ limit: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "retailer_sent_history"
        serverRequest.id = userId
        serverRequest.limit = limit
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func getRetailerSentHistoryDetails(_ orderId: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "retailer_sent_history_details"
        serverRequest.orderId = orderId
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func getStockByBrandModelDetails(_ userId: String,_ brandId: String,_ modelId: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "get_stock_by_brand_model"
        serverRequest.id = userId
        serverRequest.brandId = brandId
        serverRequest.modelId = modelId
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    
    static func getAllInstallations(_ userId: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "all_installations"
        serverRequest.id = userId
        AppLog.debug(tag: "PARAM_GET_ALL_INSTALLATION", msg: "\(serverRequest.toJSON())")
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func getQRDetails(_ qrCode: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "qr_details"
        serverRequest.qrCode = qrCode
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    
    static func getVehicleBrands() -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "vehicle_brands"
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }

    static func getVehicleModels(_ brandId: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "vehicle_models"
        serverRequest.brandId = brandId
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }


    
    static func becomeAMember(_ serverRequest: ServerRequest) -> DataRequest {
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func getAllOemInstallation() -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "all_oem_installation"
        //serverRequest.id = PrefrenceUtils.getUserId()
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func updateRegNo( _ id: String, _ registerNo: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "update_reg_no"
        serverRequest.id = id
        serverRequest.registrationNo = registerNo
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func getAllNotifications() -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "get_all_notifications"
        //serverRequest.id = PrefrenceUtils.getUserId()
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func getUpdateReadStatus(notificationId: String, readStatus: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "update_read_status"
        serverRequest.id = notificationId
        serverRequest.readStatus = readStatus
        AppLog.debug(tag: "PARAM_UPDATE_READ_STATUS", msg: "\(serverRequest.toJSON())")
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func deleteSingleNotificationRequest(notificationId: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "delete_notification"
        serverRequest.id = notificationId
        AppLog.debug(tag: "PARAM_DELETE_SINGLE_NOTIFICATION", msg: "\(serverRequest.toJSON())")
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func deleteAllNotificationRequest() -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "delete_all_notification"
        //serverRequest.id = PrefrenceUtils.getUserId()
        AppLog.debug(tag: "PARAM_DELETE_ALL_NOTIFICATION", msg: "\(serverRequest.toJSON())")
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }

    
    static func getQRCode(_ orderId: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "get_qr_codes"
        serverRequest.orderId = orderId
        AppLog.debug(tag: "PARAM_GET_QRCODE", msg: "\(serverRequest.toJSON())")
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func getRequestedQRCode(_ orderId: String) -> DataRequest {
        let serverRequest = ServerRequest()
        serverRequest.tag = "get_requested_qr_codes"
        serverRequest.id = orderId
        AppLog.debug(tag: "PARAM_GET_REQUESTED_QRCODE", msg: "\(serverRequest.toJSON())")
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }
    
    static func replaceQRCode(_ serverRequest: ServerRequest) -> DataRequest {
        print(serverRequest.toJSON())
        return RestRequest.getPostRequest(serverRequest.toJSON())
    }*/
    
   
    
}

