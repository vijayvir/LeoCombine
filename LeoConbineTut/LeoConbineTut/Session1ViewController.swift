//
//  ViewController.swift
//  swiftindia-combine-workshop
//
//  Created by Ritesh Gupta on 04/02/20.
//  Copyright © 2020 Ritesh Gupta. All rights reserved.
//

import UIKit
import Combine

struct DemoError: Error {}

class Session1ViewController: UIViewController {

    // It stores all the subscribers which are AnyCancellable
    var cancellables: [AnyCancellable] = []

    // @Published Publisher
    @Published var publishedPublisher: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // 1. What is a Publisher
    func whatIsAPublisher() {
        // PassthroughSubject is actually a Subject which is a special Publisher
        let p1 = PassthroughSubject<String, Error>()
        p1.send("Ritesh")
        p1.send("Gupta")
        p1.send(completion: .finished)
        print("Done!!!")
    }

    // 2. Different types of Publishers supported by Combine
    func differentKindsOfPublishersInCombine() {
        // Just
        _ = Just("Ritesh Gupta")

        // Fail
        _ = Fail(outputType: String.self, failure: DemoError())

        // Future
        _ = Future<String, Error> { promise in
            promise(.success("Ritesh Gupta"))
            promise(.failure(DemoError()))
        }

        // Deferred
        _ = Deferred {
            Just("Ritesh Gupta")
        }

        // DataTaskPublisher
        _ = URLSession.shared.dataTaskPublisher(
            for: URL(string: "https://www.riteshhh.com")!
        )

        // NotificationCenter.Publisher
        _ = NotificationCenter.default.publisher(
            for: Notification.Name("notification-demo"),
            object: nil
        )

        // NSObject.KeyValueObservingPublisher
        _ = self.publisher(for: \.view?.isHidden)

        // @Published
        _ = $publishedPublisher

        // PassthroughSubject
        _ = PassthroughSubject<String, Never>()

        // CurrentValueSubject
        _ = CurrentValueSubject<String, Never>("Ritesh Gupta")

        // AnyPublisher
        _ = $publishedPublisher.eraseToAnyPublisher()

        // Result.Publisher
        _ = Result<String, Error>.success("Ritesh Gupta").publisher

        // Optional.Publisher
        _ = Optional<String>.Publisher(nil)
    }

    // 3. What is a Subscriber
    func whatIsASubscriber() {
        let publisher = PassthroughSubject<String, Never>()
        publisher
            .sink(receiveValue: { print($0) })
            .store(in: &cancellables)
        publisher.send("Ritesh")
        publisher.send("Ritesh Gupta")
    }

    // 4. Different kind of Subscribers
    func differentKindsOfSubscriberInCombine() {
        // Sink
        let p1 = PassthroughSubject<String, Never>()
        p1.sink(receiveValue: { print($0) }).store(in: &cancellables)
        p1.send("Ritesh")
        p1.send("Ritesh Gupta")

        let p2 = PassthroughSubject<String, Never>()
        let sink = Subscribers.Sink<String, Never>(
            receiveCompletion: { _ in },
            receiveValue: { print($0) }
        )
        p2.subscribe(sink)
        p2.send("Ritesh")
        p2.send("Ritesh Gupta")

        // Assign
        let p3 = PassthroughSubject<Bool, Never>()
        
    
        p3.assign(to: \.isHidden, on: self.view).store(in: &cancellables)
        p3.send(true)

        let p4 = PassthroughSubject<Bool, Never>()
        let assign = Subscribers.Assign(object: self.view, keyPath: \.isHidden)
    
        p4.subscribe(assign)
        p4.send(false)

        // AnySubscriber
        // First need to understand lifecycle
        let p5 = PassthroughSubject<Bool, Never>()
        let subscriber = AnySubscriber<Bool, Never>(
            receiveSubscription: { subscription in subscription.request(.unlimited) },
            receiveValue: { value in print(value); return .none },
            receiveCompletion: nil
        )
        p5.subscribe(subscriber)
        p5.send(false)
    }
    
    func quickTime💡_differentKindsOfSubscriberInCombine() {
        // 1.
        //        let p1 = PassthroughSubject<String, Never>()
        //        p1.assign(to: \.title, on: self).store(in: &cancellables)

        // 2.
        //        let p2 = PassthroughSubject<Bool, Error>()
        //        let assign2 = Subscribers.Assign(object: self, keyPath: \.isHidden)
        //        p2.subscribe(assign2)

        // 3.
        //        let p3 = PassthroughSubject<UIColor?, Never>()
        //        p3.assign(to: , on: ).store(in: &cancellables)
        //        p3.send(.blue)
    }

    // Lifecycle of publishers & subscribers
    func lifecycleOfPublisherAndSubscriber() {
        // 1 .
        let publisher = PassthroughSubject<Bool, Never>()
        
        // 2.
        let subscriber = AnySubscriber<Bool, Never>(
            receiveSubscription: { subscription in subscription.request(.unlimited) },
            receiveValue: { _ in return .none },
            receiveCompletion: nil
        )
        
        // 3.
        publisher.print().subscribe(subscriber)
                
        // 4.
        publisher.send(false)
        publisher.send(false)
        publisher.send(false)

        // 5.
        publisher.send(completion: .finished)
    }
    
    func quickTime💡_lifecycleOfPublisherAndSubscriber() {
        // 1. Make a publisher of type String as output and DemoError as error
        // 2. Make a subscriber of type String as output and DemoError as error
        // 3. Link publisher with subscriber
        // 4. Add print() to log debug values
        // 5. Send some string via publisher
        // 6. Send error via publisher
    }
    
    // Cancellable
    func howToCancelSubscription() {
        let p1 = PassthroughSubject<String, Never>()
        let sink1 = p1.sink(receiveValue: { print($0) })
        sink1.store(in: &cancellables)
        p1.send("Ritesh")
        sink1.cancel()
        p1.send("Ritesh Gupta")
    }
}
