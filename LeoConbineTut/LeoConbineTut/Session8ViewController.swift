//
//  Session8ViewController.swift
//  swiftindia-combine-workshop
//
//  Created by Ritesh Gupta on 08/02/20.
//  Copyright © 2020 Ritesh Gupta. All rights reserved.
//

import UIKit
import Combine

class Session8ViewController: UIViewController {
    
    // It stores all the subscribers which are AnyCancellable
    var cancellables: [AnyCancellable] = []
    
    @Published var user: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 1.
    func freezeLoader() {
        let publisher = CurrentValueSubject<String, Never>("Ritesh")
        publisher
            .map { _ in self.someHeavyTask() }
            .map { "Done!!!" }
            .sink(receiveValue: { print($0) })
            .store(in: &cancellables)
    }
    
    // 2.
    func smoothLoading() {
        let publisher = CurrentValueSubject<String, Never>("Ritesh")
        publisher
            .subscribe(on: DispatchQueue.global())
            .map { _ in self.someHeavyTask() }
            .receive(on: DispatchQueue.main)
            .map { "Done!!!" }
            .sink(receiveValue: { print($0) })
            .store(in: &cancellables)
    }
    
    func someHeavyTask() {
        (0..<1000000).forEach { _ in _ = DateFormatter() }
    }
}
