//
//  Session7ViewController.swift
//  swiftindia-combine-workshop
//
//  Created by Ritesh Gupta on 07/02/20.
//  Copyright © 2020 Ritesh Gupta. All rights reserved.
//

import UIKit
import Combine

class Session7ViewController: UIViewController {
    
    // It stores all the subscribers which are AnyCancellable
    var cancellables: [AnyCancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debounce()
    }
    
    // 1.
    func merge() {
        let api1 = CurrentValueSubject<String, Never>("Ritesh")
        let api2 = CurrentValueSubject<String, Never>("Kumar")
        let api3 = CurrentValueSubject<String, Never>("Gupta")
        
        Publishers.MergeMany(
            api1.delay(for: 0, scheduler: DispatchQueue.main),
            api2.delay(for: 1, scheduler: DispatchQueue.main),
            api3.delay(for: 2, scheduler: DispatchQueue.main)
        )
            .sink(receiveValue: { print($0) })
            .store(in: &cancellables)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            api3.send("Swift")
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            api2.send("India")
//        }
    }
    
    // 2.
    func zip() {
        let api1 = CurrentValueSubject<String, Never>("Ritesh")
        let api2 = CurrentValueSubject<String, Never>("Kumar")
        let api3 = CurrentValueSubject<String, Never>("Gupta")
        
        Publishers.Zip3(
            api1.delay(for: 0, scheduler: DispatchQueue.main),
            api2.delay(for: 1, scheduler: DispatchQueue.main),
            api3.delay(for: 2, scheduler: DispatchQueue.main)
        )
            .sink(receiveValue: { print($0) })
            .store(in: &cancellables)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            api3.send("Swift")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            api2.send("India")
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            api1.send("202")
//        }
    }
    
    // 3.
    func combineLatest() {
        let api1 = CurrentValueSubject<String, Never>("Ritesh")
        let api2 = CurrentValueSubject<String, Never>("Kumar")
        let api3 = CurrentValueSubject<String, Never>("Gupta")
        
        Publishers.CombineLatest3(
            api1.delay(for: 0, scheduler: DispatchQueue.main),
            api2.delay(for: 1, scheduler: DispatchQueue.main),
            api3.delay(for: 2, scheduler: DispatchQueue.main)
        )
            .sink(receiveValue: { print($0) })
            .store(in: &cancellables)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            api3.send("Swift")
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            api3.send("India")
//        }
    }
    
    // 4.
    func debounce() {
        let publisher = PassthroughSubject<String, Never>()
        publisher
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .sink(receiveValue: { print($0) })
            .store(in: &cancellables)
        
        // t
        publisher.send("R")
        
        // t + some milli second
        publisher.send("i")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//        }

        // t + some more milli second
        publisher.send("t")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//        }
    }
    
    // Quiz Time 💡
    func quizTime💡() {
        let taskA = Just("A").delay(for: 2, scheduler: DispatchQueue.main)
        let taskB = Just("B").delay(for: 1, scheduler: DispatchQueue.main)
        
        // Between A & B, we have to pick whichever send its value first
        //        let taskAB =
        
        let taskC = Just("C").delay(for: 1, scheduler: DispatchQueue.main)
        let taskD = Just("D").delay(for: 2, scheduler: DispatchQueue.main)

        // Between C & D, we have to pick whichever send its value first
        //        let taskCD =
        
        // Between AB & CD, we have to wait for both of them to finish
        //        let taskABCD =
    }
}
