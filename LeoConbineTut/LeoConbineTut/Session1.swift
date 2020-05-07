//
//  Session1.swift
//  LeoConbineTut
//
//  Created by tecH on 08/05/20.
//  Copyright © 2020 vijayvir Singh. All rights reserved.
//
// Follow the Tut from Top to bottom
import Foundation
import UIKit
import Combine
struct DemoError: Error {}
class Session1 {
     static var cancellables: [AnyCancellable] = []
    // First of all run the one sample to see publisher and subscriber effect in code
    class func sample() {
          // PassthroughSubject is actually a Subject which is a special Publisher
        
          let p1 = PassthroughSubject<String, Never>()
          p1.send("This is not called as is is called before the sink")
        
         // Sink is one type of subscriber
          p1.sink(receiveValue: { print($0) })
          .store(in: &cancellables)
          p1.send("This is called as is written after the sink")
          p1.send("This is also called")
          p1.send(completion: .finished)
          p1.send("This is not called as finished event is called")
      }
    
    // 1. What is a Publisher
    class func whatIsAPublisher() {
        // PassthroughSubject is actually a Subject which is a special Publisher
        let p1 = PassthroughSubject<String, Never>()
        // Apple Docs
        //Unlike CurrentValueSubject, a PassthroughSubject doesn’t have an initial value or a buffer of the most recently-published element. A PassthroughSubject drops values if there are no subscribers, or its current demand is zero.
        p1.send("This is called as is written after the sink")
     
        p1.sink(receiveValue: { print($0) })
              .store(in: &cancellables)
         p1.send("this is  called")
        p1.send(completion: .finished)
        p1.send("this is not called")
      
        
        // Question in Queue
        // What is Never?
    }
    
    
    class func justPublisher(){
        // Just
                  let pJust = Just("Initial value in Just Publisher")
                  // It not have send event
                 pJust.sink { (value) in
                  print(value)
                 }.store(in: &cancellables)
        
        // Apple Docs
        //You can use a Just publisher to start a chain of publishers. A Just publisher is also useful when replacing a value with Publishers.Catch.
       // In contrast with Result.Publisher, a Just publisher can’t fail with an error. And unlike Optional.Publisher, a Just publisher always produces a value.
        
    }
    class func failPub() {
        // Fail
        let p1 = Fail(outputType: String.self, failure: DemoError())
        // Apple
        // A publisher that immediately terminates with the specified error.
        p1.sink(receiveCompletion: { (error) in
            print("receiveCompletion with infer type error is called--->",error)
        }) { (value) in
            print(value)
        }
        
    }
    
    class func futurePub(){
        
        //  Apple Docs
        // A publisher that eventually produces a single value and then finishes or fails
                  let p1 = Future<String, Error> { promise in
                      promise(.success("first success promise"))
                     promise(.success("second success promise"))
                      promise(.failure(DemoError()))
                      promise(.success("third after failure success promise"))
                  }
        p1.sink(receiveCompletion: { (subComplisherError) in
            print("subComplisherError is called", subComplisherError)
        }) { (value ) in
            print("Recieve value closure is called - > " , value)
        }
    }
    class func defferPub() {
        // Deferred
        //A publisher that awaits subscription before running the supplied closure to create a publisher for the new subscriber.
        
        
        
              let p1 = Deferred {
                  Just("just publisher in Deffer is called")
              }
        p1.sink(receiveCompletion: { (subcompletionError) in
            print("subcompletionError-> ", subcompletionError)
        }) { (value ) in
            print("Recieve value ",value)
        }
    }
    class func differentKindsOfPublishersInCombine() {
         
        
        

        
         

        

      

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
          // _ = self.publisher(for: \.view?.isHidden)

           // @Published
          // _ = $publishedPublisher

           // PassthroughSubject
           _ = PassthroughSubject<String, Never>()

           // CurrentValueSubject
           _ = CurrentValueSubject<String, Never>("Ritesh Gupta")

           // AnyPublisher
           //_ = $publishedPublisher.eraseToAnyPublisher()

           // Result.Publisher
           _ = Result<String, Error>.success("Ritesh Gupta").publisher

           // Optional.Publisher
           _ = Optional<String>.Publisher(nil)
       }
    
    // 3. What is a Subscriber
   class func whatIsASubscriber() {
        let publisher = PassthroughSubject<String, Never>()
        publisher
            .sink(receiveValue: { print($0) })
            .store(in: &cancellables)
        publisher.send("Ritesh")
        publisher.send("Ritesh Gupta")
    }

}

