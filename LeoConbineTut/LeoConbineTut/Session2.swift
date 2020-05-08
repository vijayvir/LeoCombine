//
//  Session2.swift
//  LeoConbineTut
//
//  Created by tecH on 08/05/20.
//  Copyright © 2020 vijayvir Singh. All rights reserved.
//
import Combine
import UIKit
import Foundation
class Session2{
    
    // It stores all the subscribers which are AnyCancellable
    static var cancellables: [AnyCancellable] = []


    
    // 1. What is an Operator
    class func whatIsAnOperator() {
        let publisher = PassthroughSubject<String, Error>()
        publisher
            // These are the operator
            .map { $0.capitalized } // cast to
            .map { Int($0) }
            .compactMap { $0 } // remove nil
            .filter { $0 % 2 == 0 }
            .sink(receiveCompletion: { _ in }, receiveValue: { print($0) })
            .store(in: &cancellables)
        publisher.send("Ritesh")
        publisher.send("1")
        publisher.send("2")
        publisher.send("4")
    }
    
    // 2. Different types of Operators supported by Combine
    func differentKindsOfOperatorsInCombine() {
        let publisher = PassthroughSubject<String, Never>()
        // Map
        _ = publisher.map { $0.capitalized }
        
        // FlatMap
        _ = publisher.flatMap { Just($0) }

        // Filter
        _ = publisher.filter { $0.isEmpty }
        
        // Catch
        _ = publisher.catch { Fail(error: $0) }
        
        // MapError
        //_ = publisher.mapError { _ in DemoError() }
        
        // Merge
        let publisher2 = PassthroughSubject<String, Never>()
        _ = publisher.merge(with: publisher2)
        
        // Zip
        let publisher3 = PassthroughSubject<Int, Never>()
        _ = publisher.zip(publisher3)
    }
    
    // Quick Time 💡
    class func quickTime💡_differentKindsOfOperatorsInCombine() {
        let publisher = PassthroughSubject<String, Never>()
        
        publisher
            // 1. Use an operator to remove whitespaces
            // 2. Use an opertor to remove empty strings
            // 3. Use an operator to capitalize the string
            .sink(receiveValue: { print($0) }).store(in: &cancellables)
        
        publisher.send("")
        publisher.send("  ")
        publisher.send(" ritesh ")
    }
}
