//
//  Session5ViewController.swift
//  swiftindia-combine-workshop
//
//  Created by Ritesh Gupta on 07/02/20.
//  Copyright © 2020 Ritesh Gupta. All rights reserved.
//

import UIKit
import Combine

struct DemoError1: Error {}

enum DemoErorr2: Error {
    case someError(Error)
}

class Session5ViewController: UIViewController {
    
    // It stores all the subscribers which are AnyCancellable
    var cancellables: [AnyCancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 1. How to model custom Error
    func howToModelCustomError() {
        // DemoError1
        // DemoError2
    }
    
    // 2. How does Error flow
    func howDoesErrorFlow() {
        let publisher = PassthroughSubject<String, Error>()
        
        publisher
            .sink(receiveCompletion: { print($0) }, receiveValue: { _ in })
            .store(in: &cancellables)
        
        publisher.send(completion: .failure(DemoError1()))
    }
    
    // 3. How to react to errors
    func howToReactToErrors() {
        // 1. Sink
        let publisher1 = PassthroughSubject<String, Error>()
        publisher1.sink(
            receiveCompletion: ({
                switch $0 {
                case .finished: break
                case .failure(let error): print(error.localizedDescription)
                }
            }),
            receiveValue: { _ in })
            .store(in: &cancellables)
        
        publisher1.send(completion: .failure(DemoError1()))
        
        // Catch
        let publisher2 = PassthroughSubject<String, Error>()
        publisher2
            .catch ({ error in
                return Just("I'm inside Catch!!!")
            })
            .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })
            .store(in: &cancellables)
        
        publisher2.send(completion: .failure(DemoError1()))
        
        // Catch
        let publisher3 = PassthroughSubject<String, Error>()
        publisher3
            .catch ({ error in
                return Fail(error: DemoErorr2.someError(error))
            })
            .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })
            .store(in: &cancellables)
        
        publisher3.send(completion: .failure(DemoError1()))
        
        // TryCatch
        let publisher4 = PassthroughSubject<String, Error>()
        publisher4
            .tryCatch ({ (error: Error) throws -> AnyPublisher<String, Error> in
                throw DemoErorr2.someError(error)
            })
            .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })
            .store(in: &cancellables)
        
        publisher4.send(completion: .failure(DemoError1()))
        
        // MapError
        let publisher5 = PassthroughSubject<String, Error>()
        publisher5
            .mapError { DemoErorr2.someError($0) }
            .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })
            .store(in: &cancellables)
        
        publisher5.send(completion: .failure(DemoError1()))
        
        // ReplaceError
        let publisher6 = PassthroughSubject<String, Error>()
        publisher6
            .replaceError(with: "Ritesh Gupta")
            .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })
            .store(in: &cancellables)
    }
    
    // 4. A Note about `Never`
    func aNoteAboutNever() {
        // It can never produce a value nor fail
        // It can only complete
        let publisher1 = PassthroughSubject<Never, Never>()
        publisher1.send(completion: .finished)
        
        // It can never fail, can only produce a value and complete
        _ = PassthroughSubject<String, Never>()
        
        // It can never produce a value, can only fail and complete
        _ = PassthroughSubject<Never, Error>()
        
        // Just is a special operator which can onlt produce a value and complete
        // Just can never fail
        _ = Just("Ritesh Gupta")
        
        // SetFailureType
        let p2 = PassthroughSubject<String, Never>()
        _ = p2.setFailureType(to: DemoErorr2.self)
    }
    
    // Quiz Time 💡
    func quickTime💡() {
        // 1.
        enum QuizError: Error {
            case oddNumberFound
            case genericError(Error)
            case jsonError(Data)
        }
        
        let publishers1 = PassthroughSubject<Int, Error>()
        publishers1
            // Use an operator to throw error if odd number found
            .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })
            .store(in: &cancellables)
        publishers1.send(2)
        publishers1.send(4)
        publishers1.send(5)
        
        // 2.
        let publishers2 = PassthroughSubject<Int, Error>()
        publishers2
            // Use an operator to transform error to `QuizError.genericError`
            .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })
            .store(in: &cancellables)
        
        publishers2.send(completion: .failure(DemoError1()))
        
        // 3.
        let publishers3 = PassthroughSubject<String, QuizError>()
        publishers3
            // Use an operator to catch the QuizError.jsonError and decode Data to String
            .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })
            .store(in: &cancellables)
        
        let data = "Ritesh Gupta".data(using: .utf8)!
        publishers3.send(completion: .failure(QuizError.jsonError(data)))
    }
}
