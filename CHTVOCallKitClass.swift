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
@available(iOS 10.0, *)
public class CHTVOCallKitClass : NSObject
{
    
    
    
    static let CHTVOsharedInstance = CHTVOCallKitClass()

    
    
    var ringtonePlayer : AVAudioPlayer!
    var playCustomRingback : Bool!
    var delegate : TVO_callKitDelegate!
    var callUUID : NSUUID!
    var callKitProvider : CXProvider!
    var callKitCallController : CXCallController!
    var callObserver : CXCallObserver!
    var calls_uuids_twilio : NSMutableArray!
    var userInitiatedDisconnect : Bool!
    var audioDevice : DefaultAudioDevice!
    var activeCall : Call!
    var twilio_callinvite : CallInvite!
    var activeCalls : [String: Call]! = [:]
    var activeCallInvites : [String: CallInvite]! = [:]
    var providerDelegate : CHTVOCallKitClass!
    let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTSzYwNzNmNWJiMmM3OTY1ZTRlOGE3OTAwMGEzMTI2N2IxLTE2MTE4MzA5NzYiLCJncmFudHMiOnsiaWRlbnRpdHkiOiI1Yjk3N2E4ZGYxOWM3YzE3MjQ2NTA2MDgtaW9zIiwidm9pY2UiOnsiaW5jb21pbmciOnsiYWxsb3ciOnRydWV9LCJvdXRnb2luZyI6eyJhcHBsaWNhdGlvbl9zaWQiOiJBUDE4ODY5ZjMwZWQ1ODViMzBmZjFlMDQ0OGNmMGJjZjUwIn0sInB1c2hfY3JlZGVudGlhbF9zaWQiOiJDUmViMzMxN2ExY2RjNjM0NDM4NzY1N2NmZTVjMGQ0YjE4In19LCJpYXQiOjE2MTE4MzA5NzYsImV4cCI6MTYxMTkxNzM3NiwiaXNzIjoiU0s2MDczZjViYjJjNzk2NWU0ZThhNzkwMDBhMzEyNjdiMSIsInN1YiI6IkFDZGM5MGY4MmU3NzdhOGE5OWNlMWZmZTBkOWRiNTZiZjkifQ.wMt60ER3r3TCdo9u130cMmqzS39egByiDvpkjRpFPOg"
   // var outgoingParamDict:[String:String]
    
    
    var callKitCompletionCallback: ((Bool) -> Void)? = nil

   
    override init() {
        
        super.init()
        let configuration = CXProviderConfiguration(localizedName: "CHVoice")
        configuration.maximumCallGroups = 1
        configuration.maximumCallsPerCallGroup = 1
        callKitProvider = CXProvider(configuration: configuration)
//        let icon = UIImage.init(named: "")
//        configuration.iconTemplateImageData = UIImagePNGRepresentation(icon!)
        
        
        if let provider = callKitProvider {
            
            provider.setDelegate(self, queue: nil)
        }
        
        self.callKitProvider = CXProvider.init(configuration: configuration)
        self.callKitProvider.setDelegate(self, queue: DispatchQueue.main)
        self.callKitCallController = CXCallController()
       // self.callKitCallController.callObserver.setDelegate(self, queue: DispatchQueue.main)
       
        self.playCustomRingback = true;
        
        

    }
    
    deinit {
        // CallKit has an odd API contract where the developer must call invalidate or the CXProvider is leaked.
        if let provider = callKitProvider {
            provider.invalidate()
        }
    }

    
    
    
    
}

// MARK: - CXProviderDelegate

@available(iOS 10.0, *)
extension CHTVOCallKitClass: CXProviderDelegate {
    public func providerDidReset(_ provider: CXProvider) {
        NSLog("providerDidReset:")
        audioDevice.isEnabled = false
    }

    public func providerDidBegin(_ provider: CXProvider) {
        NSLog("providerDidBegin")
    }

    public func provider(_ provider: CXProvider, didActivate audioSession: AVAudioSession) {
        NSLog("provider:didActivateAudioSession:")
        audioDevice.isEnabled = true
    }

    public func provider(_ provider: CXProvider, didDeactivate audioSession: AVAudioSession) {
        NSLog("provider:didDeactivateAudioSession:")
        audioDevice.isEnabled = false
    }

    public func provider(_ provider: CXProvider, timedOutPerforming action: CXAction) {
        NSLog("provider:timedOutPerformingAction:")
    }

    public func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
        NSLog("provider:performStartCallAction:")
        
        
        
        provider.reportOutgoingCall(with: action.callUUID, startedConnectingAt: Date())
        
        performVoiceCall(uuid: action.callUUID, client: "") { success in
            if success {
                NSLog("performVoiceCall() successful")
                provider.reportOutgoingCall(with: action.callUUID, connectedAt: Date())
            } else {
                NSLog("performVoiceCall() failed")
            }
        }
        
        action.fulfill()
    }

  /*  func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        NSLog("provider:performAnswerCallAction:")
        
        performAnswerVoiceCall(uuid: action.callUUID) { success in
            if success {
                NSLog("performAnswerVoiceCall() successful")
            } else {
                NSLog("performAnswerVoiceCall() failed")
            }
        }
        
        action.fulfill()
    }*/

    public func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        NSLog("provider:performEndCallAction:")
        
        if let invite = activeCallInvites[action.callUUID.uuidString] {
            invite.reject()
            activeCallInvites.removeValue(forKey: action.callUUID.uuidString)
        } else if let call = activeCalls[action.callUUID.uuidString] {
            call.disconnect()
        } else {
            NSLog("Unknown UUID to perform end-call action with")
        }

        action.fulfill()
    }
    
 /*   func provider(_ provider: CXProvider, perform action: CXSetHeldCallAction) {
        NSLog("provider:performSetHeldAction:")
        
        if let call = activeCalls[action.callUUID.uuidString] {
            call.isOnHold = action.isOnHold
            action.fulfill()
        } else {
            action.fail()
        }
    }
    
    func provider(_ provider: CXProvider, perform action: CXSetMutedCallAction) {
        NSLog("provider:performSetMutedAction:")

        if let call = activeCalls[action.callUUID.uuidString] {
            call.isMuted = action.isMuted
            action.fulfill()
        } else {
            action.fail()
        }
    }*/

    
    // MARK: Call Kit Actions
    func performStartCallAction(uuid: UUID, handle: String) {
        guard let provider = callKitProvider else {
            NSLog("CallKit provider not available")
            return
        }
        
        let callHandle = CXHandle(type: .generic, value: handle)
        let startCallAction = CXStartCallAction(call: uuid, handle: callHandle)
        let transaction = CXTransaction(action: startCallAction)

        callKitCallController.request(transaction) { error in
            if let error = error {
                NSLog("StartCallAction transaction request failed: \(error.localizedDescription)")
                return
            }

            NSLog("StartCallAction transaction request successful")

            let callUpdate = CXCallUpdate()
            
            callUpdate.remoteHandle = callHandle
            callUpdate.supportsDTMF = true
            callUpdate.supportsHolding = true
            callUpdate.supportsGrouping = false
            callUpdate.supportsUngrouping = false
            callUpdate.hasVideo = false

            provider.reportCall(with: uuid, updated: callUpdate)
        }
    }

  /*  func reportIncomingCall(from: String, uuid: UUID) {
        guard let provider = callKitProvider else {
            NSLog("CallKit provider not available")
            return
        }

        let callHandle = CXHandle(type: .generic, value: from)
        let callUpdate = CXCallUpdate()
        
        callUpdate.remoteHandle = callHandle
        callUpdate.supportsDTMF = true
        callUpdate.supportsHolding = true
        callUpdate.supportsGrouping = false
        callUpdate.supportsUngrouping = false
        callUpdate.hasVideo = false

        provider.reportNewIncomingCall(with: uuid, update: callUpdate) { error in
            if let error = error {
                NSLog("Failed to report incoming call successfully: \(error.localizedDescription).")
            } else {
                NSLog("Incoming call successfully reported.")
            }
        }
    }*/

    func performEndCallAction(uuid: UUID) {

        let endCallAction = CXEndCallAction(call: uuid)
        let transaction = CXTransaction(action: endCallAction)

        callKitCallController.request(transaction) { error in
            if let error = error {
                NSLog("EndCallAction transaction request failed: \(error.localizedDescription).")
            } else {
                NSLog("EndCallAction transaction request successful")
            }
        }
    }
    
    func performVoiceCall(uuid: UUID, client: String?, completionHandler: @escaping (Bool) -> Void) {
//        guard let accessToken = fetchAccessToken() else {
//            completionHandler(false)
//            return
//        }
        
        
        
        let connectOptions = ConnectOptions(accessToken: accessToken) { builder in
           // builder.params = [twimlParamTo: self.outgoingValue.text ?? ""]
            
            builder.params = ["To":"+14845933533","X-PH-Userid":"5b977a8df19c7c1724650608","X-PH-Fromnumber":"+14845440966","X-PH-Devicetype":"iOS"]
            builder.uuid = uuid
        }
        
        let call = TwilioVoiceSDK.connect(options: connectOptions, delegate: self)
        activeCall = call
        activeCalls[call.uuid!.uuidString] = call
        callKitCompletionCallback = completionHandler
    }
    
  /*  func performAnswerVoiceCall(uuid: UUID, completionHandler: @escaping (Bool) -> Void) {
        guard let callInvite = activeCallInvites[uuid.uuidString] else {
            NSLog("No CallInvite matches the UUID")
            return
        }
        
        let acceptOptions = AcceptOptions(callInvite: callInvite) { builder in
            builder.uuid = callInvite.uuid
        }
        
        let call = callInvite.accept(options: acceptOptions, delegate: self)
        activeCall = call
        activeCalls[call.uuid!.uuidString] = call
        callKitCompletionCallback = completionHandler
        
        activeCallInvites.removeValue(forKey: uuid.uuidString)
        
        guard #available(iOS 13, *) else {
            incomingPushHandled()
            return
        }
    }*/
}

// MARK: - TVOCallDelegate

@available(iOS 10.0, *)
extension CHTVOCallKitClass: CallDelegate {
   
    public func callDidStartRinging(call: Call) {
        NSLog("callDidStartRinging:")
        
       // placeCallButton.setTitle("Ringing", for: .normal)
        
        /*
         When [answerOnBridge](https://www.twilio.com/docs/voice/twiml/dial#answeronbridge) is enabled in the
         <Dial> TwiML verb, the caller will not hear the ringback while the call is ringing and awaiting to be
         accepted on the callee's side. The application can use the `AVAudioPlayer` to play custom audio files
         between the `[TVOCallDelegate callDidStartRinging:]` and the `[TVOCallDelegate callDidConnect:]` callbacks.
        */
        if playCustomRingback {
            playRingback()
        }
    }
    
    public func callDidConnect(call: Call) {
        NSLog("callDidConnect:")
        
        if playCustomRingback {
            stopRingback()
        }
        
        if let callKitCompletionCallback = callKitCompletionCallback {
            callKitCompletionCallback(true)
        }
        
//        placeCallButton.setTitle("Hang Up", for: .normal)
//
//        toggleUIState(isEnabled: true, showCallControl: true)
//        stopSpin()
//        toggleAudioRoute(toSpeaker: true)
    }
    
   public func call(call: Call, isReconnectingWithError error: Error) {
        NSLog("call:isReconnectingWithError:")
        
//        placeCallButton.setTitle("Reconnecting", for: .normal)
//
//        toggleUIState(isEnabled: false, showCallControl: false)
    }
    
   public func callDidReconnect(call: Call) {
        NSLog("callDidReconnect:")
        
//        placeCallButton.setTitle("Hang Up", for: .normal)
//
//        toggleUIState(isEnabled: true, showCallControl: true)
    }
    
    public func callDidFailToConnect(call: Call, error: Error) {
        NSLog("Call failed to connect: \(error.localizedDescription)")
        
        if let completion = callKitCompletionCallback {
            completion(false)
        }
        
        if let provider = callKitProvider {
            provider.reportCall(with: call.uuid!, endedAt: Date(), reason: CXCallEndedReason.failed)
        }

        callDisconnected(call: call)
    }
    
    public func callDidDisconnect(call: Call, error: Error?) {
        if let error = error {
            NSLog("Call failed: \(error.localizedDescription)")
        } else {
            NSLog("Call disconnected")
        }
        
        if !userInitiatedDisconnect {
            var reason = CXCallEndedReason.remoteEnded
            
            if error != nil {
                reason = .failed
            }
            
            if let provider = callKitProvider {
                provider.reportCall(with: call.uuid!, endedAt: Date(), reason: reason)
            }
        }

        callDisconnected(call: call)
    }
    
   public func callDisconnected(call: Call) {
        if call == activeCall {
            activeCall = nil
        }
        
        activeCalls.removeValue(forKey: call.uuid!.uuidString)
        
        userInitiatedDisconnect = false
        
        if playCustomRingback {
            stopRingback()
        }
        
//        stopSpin()
//        toggleUIState(isEnabled: true, showCallControl: false)
//        placeCallButton.setTitle("Call", for: .normal)
    }
    
   public func call(call: Call, didReceiveQualityWarnings currentWarnings: Set<NSNumber>, previousWarnings: Set<NSNumber>) {
        /**
        * currentWarnings: existing quality warnings that have not been cleared yet
        * previousWarnings: last set of warnings prior to receiving this callback
        *
        * Example:
        *   - currentWarnings: { A, B }
        *   - previousWarnings: { B, C }
        *   - intersection: { B }
        *
        * Newly raised warnings = currentWarnings - intersection = { A }
        * Newly cleared warnings = previousWarnings - intersection = { C }
        */
        var warningsIntersection: Set<NSNumber> = currentWarnings
        warningsIntersection = warningsIntersection.intersection(previousWarnings)
        
        var newWarnings: Set<NSNumber> = currentWarnings
        newWarnings.subtract(warningsIntersection)
        if newWarnings.count > 0 {
            qualityWarningsUpdatePopup(newWarnings, isCleared: false)
        }
        
        var clearedWarnings: Set<NSNumber> = previousWarnings
        clearedWarnings.subtract(warningsIntersection)
        if clearedWarnings.count > 0 {
            qualityWarningsUpdatePopup(clearedWarnings, isCleared: true)
        }
    }
    
    func qualityWarningsUpdatePopup(_ warnings: Set<NSNumber>, isCleared: Bool) {
        var popupMessage: String = "Warnings detected: "
        if isCleared {
            popupMessage = "Warnings cleared: "
        }
        
//        let mappedWarnings: [String] = warnings.map { number in warningString(Call.QualityWarning(rawValue: number.uintValue)!)}
//        popupMessage += mappedWarnings.joined(separator: ", ")
//
//        qualityWarningsToaster.alpha = 0.0
//        qualityWarningsToaster.text = popupMessage
//        UIView.animate(withDuration: 1.0, animations: {
//            self.qualityWarningsToaster.isHidden = false
//            self.qualityWarningsToaster.alpha = 1.0
//        }) { [weak self] finish in
//            guard let strongSelf = self else { return }
//            let deadlineTime = DispatchTime.now() + .seconds(5)
//            DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
//                UIView.animate(withDuration: 1.0, animations: {
//                    strongSelf.qualityWarningsToaster.alpha = 0.0
//                }) { (finished) in
//                    strongSelf.qualityWarningsToaster.isHidden = true
//                }
//            })
//        }
    }
    
    func warningString(_ warning: Call.QualityWarning) -> String {
        switch warning {
        case .highRtt: return "high-rtt"
        case .highJitter: return "high-jitter"
        case .highPacketsLostFraction: return "high-packets-lost-fraction"
        case .lowMos: return "low-mos"
        case .constantAudioInputLevel: return "constant-audio-input-level"
        default: return "Unknown warning"
        }
    }
    
    
    // MARK: Ringtone
    
    func playRingback() {
        let ringtonePath = URL(fileURLWithPath: Bundle.main.path(forResource: "ringtone", ofType: "wav")!)
        
        do {
            ringtonePlayer = try AVAudioPlayer(contentsOf: ringtonePath)
            ringtonePlayer?.delegate = self as! AVAudioPlayerDelegate
            ringtonePlayer?.numberOfLoops = -1
            
            ringtonePlayer?.volume = 1.0
            ringtonePlayer?.play()
        } catch {
            NSLog("Failed to initialize audio player")
        }
    }
    
    func stopRingback() {
        guard let ringtonePlayer = ringtonePlayer, ringtonePlayer.isPlaying else { return }
        
        ringtonePlayer.stop()
    }
}

