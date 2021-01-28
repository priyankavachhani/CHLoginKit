//
//  CHTVOCallKitClass.swift
//  CHLoginKit
//
//  Created by Apple on 28/01/21.
//

import Foundation
import TwilioVoice
import CallKit

protocol TVO_callKitDelegate {
   
    func callDidStartRinging_custom(call : Call) -> Void
    func callDidConnect_custom(call : Call) -> Void
    func callDidReconnect_custom(call : Call) -> Void
    func CHcallDelegate(callInvite :CallInvite, uuid : NSUUID) -> Void
    func callDisconnected_custom(call :Call) -> Void
    func call(call :Call, isReconnectingWithError_custom : NSError) -> Void
    func call(call :Call, didFailToConnectWithError_custom : NSError) -> Void
    func call(call :Call, didDisconnectWithError_custom : NSError) -> Void
    
}
public class CHTVOCallKitClass : NSObject
{
    
    
    
}
