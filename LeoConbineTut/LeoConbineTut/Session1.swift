//
//  Session1.swift
//  LeoConbineTut
//
//  Created by tecH on 08/05/20.
//  Copyright © 2020 vijayvir Singh. All rights reserved.
//
// Follow the Tut from Top to bottom
import Foundation
import Combine
class Session1 {
    
    // First of all run the one sample to see publisher and subscriber effect in code
    class   func sample() {
          // PassthroughSubject is actually a Subject which is a special Publisher
         var cancellables: [AnyCancellable] = []
          let p1 = PassthroughSubject<String, Never>()
          p1.send("This is not called as is is called before the sink")
        
         // Sink is one type of subsiber
          p1.sink(receiveValue: { print($0) })
          .store(in: &cancellables)
          p1.send("This is called as is written after the sink")
          p1.send("This is also called")
          p1.send(completion: .finished)
          p1.send("This is not called as finished event is called")
      }
    
    
    
}

