//
//  ViewController.swift
//  WatchConnectivityTutorial
//
//  Created by Tiberiu Popescu on 27/06/2018.
//  Copyright © 2018 Tiberiu Popescu. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {


    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }
    func sessionDidBecomeInactive(_ session: WCSession) { }
    func sessionDidDeactivate(_ session: WCSession) { }
    

    var session: WCSession!
    @IBOutlet weak var messageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(WCSession.isSupported()) {
            self.session = WCSession.default
            self.session.delegate = self
            self.session.activate()
        }
//        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sendMessageToWatch(_ sender: Any) {
        //send message to watch
        print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
        NSLog("send message to watch sent !!! ------- --------------- -----------==========================--------------------");
        session.sendMessage(["a":"hello"], replyHandler: nil, errorHandler: nil)
        
    }
    
    func readRSSI() {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        //recieve messages from watch
        self.messageLabel.text = message["b"]! as? String
        DispatchQueue.main.async {
            self.messageLabel.text = message["b"]! as? String
        }
    }
}

