//
//  DelayedValue.swift
//  CombinePlay
//
//  Created by Łukasz Dziedzic on 02/11/2023.
//

import Foundation
import Observation

@Observable
class DelayedValue {

    private var realValue: Double
    var isReady: Bool = true
    
    func calculator(_ newValue: Double) async {
        isReady = false
        //let date = Date.now
        var j = 0
        for i in 0...Int(newValue) * 1000000 {
            j += i
        }
        //let inte3rval = Date.now.timeIntervalSince(date)
        realValue = newValue + 1
        isReady = true
    }
    
    var value: Double {
      
        get { return realValue }
        set { 
            realValue = newValue
            Task { await calculator(newValue) }
        }
    }
    
    init(_ realValue: Double) {
        self.realValue = realValue
        self.isReady = false
        Task { await calculator(realValue)}
    }
    
    
}
