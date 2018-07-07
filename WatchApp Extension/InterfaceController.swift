//
//  InterfaceController.swift
//  WatchApp Extension
//
//  Created by Tiberiu Popescu on 27/06/2018.
//  Copyright © 2018 Tiberiu Popescu. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity
import HealthKit


class InterfaceController: WKInterfaceController, WCSessionDelegate, HKWorkoutSessionDelegate {
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
        print("workout session change ??")
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        print("workout session fail ??")
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("yet another one")
    }
    

    @IBOutlet var messageLabel: WKInterfaceLabel!
    var session:WCSession!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        if(WCSession.isSupported()){
            self.session = WCSession.default
            self.session.delegate = self
            self.session.activate()
        }
    }
    
    
    let healthStore = HKHealthStore()
//    healthStore.startWorkoutSession(workoutSession) {
//    (result: Bool, error: NSError?) -> Void in
//    }
//
//    healthStore.stopWorkoutSession(workoutSession) {
//    (result: Bool, error: NSError?) -> Void in
//    }
//    healthStore.startWorkoutSession(workoutSession) {
//    (result: Bool, error: NSError?) -> Void in
//    }
    
//    healthStore.stopWorkoutSession(workoutSession) {
//    (result: Bool, error: NSError?) -> Void in
//    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
//    var timerTest : Timer?

    @IBAction func sendMessageToWatch() {
        WKInterfaceDevice.current().play(.stop)
        print("from the watch is working !!! ;';sdlfdslf lsdflds")
        self.messageLabel.setText("init function")
        if(WCSession.isSupported()) {
            self.messageLabel.setText("is supported")
//            self.session.sendMessage(["b":"goodbye"], replyHandler: nil, errorHandler: nil)
            self.session.sendMessage(["b":"goodbye"], replyHandler: { (rArg: Any) in
                print("reply static")
                print(rArg)
            }, errorHandler: { (rError: Any) in
                print("error static")
                print(rError)
            })
        }

//        let workoutConfiguration = HKWorkoutConfiguration()
//        workoutConfiguration.activityType = .traditionalStrengthTraining
//        workoutConfiguration.locationType = .indoor
//        do {
//            print("starting the try")
//            let workoutSession = try HKWorkoutSession(configuration: workoutConfiguration)
//            healthStore.start(workoutSession)
//        } catch {
//            print("catch catched")
//        }
        
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .other
        configuration.locationType = .unknown
        
        do {
            print("starting the try")
            let session = try HKWorkoutSession(configuration: configuration)
            
            session.delegate = self
            healthStore.start(session)
        }
        catch let error as NSError {
            // Perform proper error handling here...
            print("*** Unable to create the workout session: \(error.localizedDescription) ***")
        }



            var myNumber = 0;
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) {
            [weak self] timer in
            myNumber += 1;
//            self?.timerTest = nil;
            print("timer ++ 1")
//            print(self?.session.isReachable as Any);
            if (self?.session.isReachable)! {
                print("reacheable");
            } else {
                WKInterfaceDevice.current().play(.stop)
            }
//            self?.session.sendMessage(["b":"goodbye\(myNumber)"], replyHandler: { (rArg: Any) in
//                print("reply")
//                print(rArg)
//            }, errorHandler: { (rError: Any) in
//                print("error")
//                print(rError)
//            })
        }

    }
    
//    @IBAction func sendMessageToWatch() {
//        self.messageLabel.setText("init function")
//        if(WCSession.isSupported()) {
//            self.messageLabel.setText("is supported")
//            self.session.transferUserInfo(["a": "b"])
//        }
//        var myNumber = 0;
//        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) {
//            [weak self] timer in
//            myNumber += 1;
//            self?.session.sendMessage(["b":"goodbye\(myNumber)"], replyHandler: { (rArg: Any) in
//                print("reply")
//                print(rArg)
//            }, errorHandler: { (rError: Any) in
//                print("error")
//                print(rError)
//            })
//        }
//
//    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        self.messageLabel.setText(message["a"]! as? String)
    }
}
