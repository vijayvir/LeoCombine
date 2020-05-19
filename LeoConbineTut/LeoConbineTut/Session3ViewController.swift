//
//  Session3ViewController.swift
//  swiftindia-combine-workshop
//
//  Created by Ritesh Gupta on 07/02/20.
//  Copyright © 2020 Ritesh Gupta. All rights reserved.
//

import UIKit
import Combine

class Session3ViewController: UIViewController {
//
//    // It stores all the subscribers which are AnyCancellable
//    var cancellables: [AnyCancellable] = []
//
//    let isUserLoggedInKey = "username"
//    lazy var userDefaults = UserDefaults.standard
//    lazy var userDefaultsSubject = userDefaults.subject(key: isUserLoggedInKey, type: String.self)
//
//    lazy var mockValueEmitter = PassthroughSubject<String, Never>()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        userDefaultsSubject
//            .sink(receiveValue: { print($0 as Any) })
//            .store(in: &cancellables)
//
//        mockValueEmitter
//            .subscribe(userDefaultsSubject)
//
//        mockValueEmitter.send("ritesh")
//    }
}

//extension UserDefaults {
//    struct Publisher<Value>: Combine.Publisher {
//        typealias Output = Value?
//        typealias Failure = Never
//
//        private let subject = CurrentValueSubject<Output, Failure>(nil)
//
//        private let defaults: UserDefaults
//        private let key: String
//        init(defaults: UserDefaults, key: String) {
//            self.defaults = defaults
//            self.key = key
//            self.subject.send(defaults.object(forKey: key) as? Value)
//        }
//
//        func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
//            subject.subscribe(subscriber)
//        }
//    }
//
//    func publisher<Output>(key: String, type: Output.Type) -> Publisher<Output> {
//        return Publisher(defaults: self, key: key)
//    }
//
//    final class Subject<Value>: Combine.Publisher, Combine.Subscriber {
//        typealias Input = Value
//        typealias Output = Value?
//        typealias Failure = Never
//
//        private let subject = CurrentValueSubject<Output, Failure>(nil)
//
//        private let defaults: UserDefaults
//        private let key: String
//        init(defaults: UserDefaults, key: String) {
//            self.defaults = defaults
//            self.key = key
//            self.subject.send(defaults.object(forKey: key) as? Value)
//        }
//
//        func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
//            subject.subscribe(subscriber)
//        }
//
//        func receive(subscription: Subscription) {
//            subscription.request(.unlimited)
//        }
//
//        func receive(_ input: Value) -> Subscribers.Demand {
//            defaults.set(input, forKey: key)
//            subject.send(input)
//            return .none
//        }
//
//        func receive(completion: Subscribers.Completion<Never>) {
//        }
//    }
//
//    func subject<Output>(key: String, type: Output.Type) -> Subject<Output> {
//        return Subject(defaults: self, key: key)
//    }
//}
