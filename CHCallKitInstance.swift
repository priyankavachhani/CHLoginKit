//
//  CHCallKitInstance.swift
//  CHLoginKit
//
//  Created by Apple on 27/01/21.
//

import Foundation
import TwilioVoice


public protocol TVO_callKitDelegate {
   
    func callStartRingingEvent() -> Void
    func callDidConnect_custom(call : Call) -> Void
    func callDidReconnect_custom(call : Call) -> Void
    func CHcallDelegate(callInvite :CallInvite, uuid : NSUUID) -> Void
    func callDisconnected_custom(call :Call) -> Void
    func call(call :Call, isReconnectingWithError_custom : NSError) -> Void
    func call(call :Call, didFailToConnectWithError_custom : NSError) -> Void
    func call(call :Call, didDisconnectWithError_custom : NSError) -> Void
    
}

public class CHCallKitInstance : NSObject
{
    
   public static let sharedchcallkitInstance = CHCallKitInstance()

      open var delegate: TVO_callKitDelegate?

    
    private override init() {
        
        
     }
    
    public func setDelegate(delegate : TVO_callKitDelegate)->Void
    {
        self.delegate = delegate
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
    
    
    public func callStartRingingEvent() {
        
        delegate?.callStartRingingEvent()
        NSLog("call start ringing : CHCallKitInstance" )

    }
    
    
}
    
    





 
