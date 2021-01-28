//
//  ViewController.swift
//  CHLoginKit
//
//  Created by priyankavachhani@callhippo.com on 01/25/2021.
//  Copyright (c) 2021 priyankavachhani@callhippo.com. All rights reserved.
//

import UIKit
import CHLoginKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func callME(_ sender: Any) {
        
        CHCallKitInstance.sharedchcallkitInstance.makeOutgoingCall(toNum: "+14845933533")
        
    }
    
    
}

