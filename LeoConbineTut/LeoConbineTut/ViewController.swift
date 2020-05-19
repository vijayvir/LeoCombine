//
//  ViewController.swift
//  LeoConbineTut
//
//  Created by tecH on 08/05/20.
//  Copyright © 2020 vijayvir Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelSome: UILabel!
    @IBAction func actionButton(_ sender: UIButton) {
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        session2()
    let some = NotificationCenter.default.publisher(
               for: Notification.Name("notification-demo"),
               object: nil
           )
    }
    func session1(){
        //Session1.sample()
        //Session1.whatIsAPublisher()
        
       //different Kinds Of Publishers In Combine
        
        //Session1.justPublisher()
        
        //Session1.failPub()
        
        //Session1.futurePub()
        
       // Session1.defferPub()
        
        //*****************************************************************************
       // Session1.whatIsASubscriber()
        
        //Session1.sinkSub()
       // Session1.sinkSeprateSub()
        //Session1.assignSub()
        
        Session1.howToCancelSubscription()
    }

    func session2(){
        Session2.whatIsAnOperator()
    }

}

