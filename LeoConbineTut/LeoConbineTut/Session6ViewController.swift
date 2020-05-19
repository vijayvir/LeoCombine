//
//  Session6ViewController.swift
//  swiftindia-combine-workshop
//
//  Created by Ritesh Gupta on 07/02/20.
//  Copyright © 2020 Ritesh Gupta. All rights reserved.
//

import UIKit
import Combine

typealias DataTaskResult = (data: Data, response: URLResponse)

struct User: Decodable {
    let name: String
    let age: Int
}

struct ApiErrorResponse: LocalizedError, Decodable {
    let message: String
    var errorDescription: String? { message }
}

enum ValidationError: Error {
    case error(Error)
    case jsonError(Data)
}

extension ValidationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .error(let e): return e.localizedDescription
        case .jsonError(let d): return "Custom Json Error: \(String.init(data: d, encoding: .utf8) ?? "\(d)")"
        }
    }
}

class Session6ViewController: UIViewController {
    
    // It stores all the subscribers which are AnyCancellable
    var cancellables: [AnyCancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 1.
    func networkingWithoutCombine() {
        let session = URLSession.shared
        let url = URL(string: "http://192.168.0.101:3000/login")!
        let task = session.dataTask(with: url) { (data, response, error) in
            // validation
            // json parsing
            // error formation
        }
        task.resume()
    }
    
    // 2.
    func networkWithCombine() {
//        let session = URLSession.shared
//        let url = URL(string: "http://192.168.0.101:3000/login")!
//        session
//            .dataTaskPublisher(for: url)
//            .validateStatusCode({ (200..<300).contains($0) })
//            .mapJsonError(to: ApiErrorResponse.self, decoder: JSONDecoder())
//            .mapJsonValue(to: User.self, decoder: JSONDecoder())
//            .sink(
//                receiveCompletion: { print($0) },
//                receiveValue: { print($0) }
//        ).store(in: &cancellables)
    }
}

extension Publisher where Output == DataTaskResult {
    func validateResponse(_ isValid: @escaping (DataTaskResult) -> Bool) -> AnyPublisher<Output, ValidationError> {
        return self
            .mapError { .error($0) }
            .flatMap { (result) -> AnyPublisher<DataTaskResult, ValidationError> in
                let (data, _) = result
                if isValid(result) {
                    return Just(result)
                        .setFailureType(to: ValidationError.self)
                        .eraseToAnyPublisher()
                } else {
                    return Fail(outputType: Output.self, failure: .jsonError(data))
                        .eraseToAnyPublisher()
                }}
            .eraseToAnyPublisher()
    }

    func validateStatusCode(_ isValid: @escaping (Int) -> Bool) -> AnyPublisher<Output, ValidationError> {
        return validateResponse { (data, response) in
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            return isValid(statusCode)
        }
    }
}

// 1. Quiz Time 💡
//extension Publisher where Failure == ValidationError {
//    func mapJsonError<E: Error & Decodable>(to errorType: E.Type, decoder: JSONDecoder) -> AnyPublisher<Output, Error> {
//    }
//}


// 2. Quiz Time 💡
//extension Publisher where Output == DataTaskResult {
//    func mapJsonValue<Output: Decodable>(to outputType: Output.Type, decoder: JSONDecoder) -> AnyPublisher<Output, Error> {
//    }
//}
