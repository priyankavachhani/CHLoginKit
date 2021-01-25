//
//  NetworkManager.swift
//  Gridle
//
//  Created by Bhavik Bansal on 12/17/16.
//  Copyright © 2016 Bhavik Bansal. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper


class NetworkManager{
    static func request(_ fullUrl : String, method: HTTPMethod,  headers: HTTPHeaders,parameters: Parameters? = nil) -> DataRequest{
        return Alamofire.request(fullUrl, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON{response in
                guard case let .failure(error) = response.result else { return }
                
                //Added ]!@#
                if let error = error as? AFError {
                    switch error {
                    case .invalidURL(let url):
                        print("Invalid URL: \(url) - \(error.localizedDescription)")
                    case .parameterEncodingFailed(let reason):
                        print("Parameter encoding failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                    case .multipartEncodingFailed(let reason):
                        print("Multipart encoding failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                    case .responseValidationFailed(let reason):
                        print("Response validation failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                        
                        switch reason {
                        case .dataFileNil, .dataFileReadFailed:
                            print("Downloaded file could not be read")
                        case .missingContentType(let acceptableContentTypes):
                            print("Content Type Missing: \(acceptableContentTypes)")
                        case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                            print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                        case .unacceptableStatusCode(let code):
                            print("Response status code was unacceptable: \(code)")
                        }
                    case .responseSerializationFailed(let reason):
                        print("Response serialization failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                    }                    
                } else if let error = error as? URLError {
                    print("URLError occurred: \(error)")
                } else {
                    print("Unknown error: \(error)")
                }
                //Ended ]!@#
                
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("NETWORK_ERROR: \(response.result.error!)")
                    //completionHandler(.failure(response.result.error!))
                    return
                }

                switch response.result{
                case .success:
                    if let response = response.response, response.statusCode == 401  {
                        print("Responce Status Code is 401")
                        return
                    }
                    break
                    
                case .failure(let error):
                    print(error)
                    break
                }
                
                if let  JSON = response.result.value,
                    let JSONData = try? JSONSerialization.data(withJSONObject: JSON, options: .prettyPrinted),
                    let prettyString = NSString(data: JSONData, encoding: String.Encoding.utf8.rawValue) {
                    print("RESPONSE FROM SERVER: \(prettyString)")
                } else if let error = response.result.error {
                    print("Error Debug Print: \(error.localizedDescription)")
                }
                
                //debugPrint("RESPONSE FROM SERVER = \(response)")
        }
    }
}


