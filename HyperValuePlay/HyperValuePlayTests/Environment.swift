
//
//  Environment.swift
//  CombinePlay
//
//  Created by Łukasz Dziedzic on 03/11/2023.
//

import Foundation
import HyperValue


import Foundation
import Observation
import HyperValue

final class MyAxis: AxisProtocol, HasCoordinateProtocol {
    var name: String
    var upperBound: Double
    var lowerBound: Double
    var position: PositionOnAxis 
    
    init(name: String, bounds: ClosedRange<Double>){
        self.name = name
        self.lowerBound = bounds.lowerBound
        self.upperBound = bounds.upperBound
        self.position = .min
    }
}
