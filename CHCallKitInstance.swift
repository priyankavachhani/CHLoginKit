//
//  CHCallKitInstance.swift
//  CHLoginKit
//
//  Created by Apple on 27/01/21.
//

import Foundation
import TwilioVoice


public class CHCallKitInstance : NSObject
{
    
   public static let sharedchcallkitInstance = CHCallKitInstance()

   
    
    private override init() {
        
        
     }
    
    
   public func makeOutgoingCall(toNum : String) -> Void {
        
        
        
        
        if #available(iOS 10.0, *) {
            
            let uuid = NSUUID()
            let handle = toNum
            CHTVOCallKitClass.CHTVOsharedInstance.performStartCallAction(uuid: uuid as UUID, handle: handle)
        } else {
            // Fallback on earlier versions
        }
    }
}
    
    





 
