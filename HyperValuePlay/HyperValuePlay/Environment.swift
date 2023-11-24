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

//typealias Hyper = HyperValue<Vertex<CGPoint>>

final class MyAxis: AxisProtocol, HasCoordinateProtocol, Identifiable {
    //var axisInstances: [AxisStyleInstance] = []
    
    //typealias AxisStyleInstance = AxisInstance
    
//    static var defaultName: String = ""
//    static var defaultShortName: String = ""
//    static var defaultBounds: ClosedRange<Double> = 0...1000
    
    var name: String
    var upperBound: Double
    var lowerBound: Double
    var position: PositionOnAxis
//    var distribution: Double? = nil
//    var shortName: String = ""
    
    required init(name: String, bounds: ClosedRange<Double>) {
        self.name = name
        self.lowerBound = bounds.lowerBound
        self.upperBound = bounds.upperBound
        self.position = .min
    }
    //Added
    convenience init(name: String, bounds: ClosedRange<Double>, shortName: String) {
        self.init(name: name, bounds: bounds)
//        self.shortName = shortName
    }
}

extension MyAxis {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(bounds)
//        hasher.combine(distribution)
        
    }
}
extension MyAxis: CustomStringConvertible {}
