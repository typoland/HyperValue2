//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 23/11/2023.
//

import Foundation
//public extension HyperValueCoordinate {
//    init (on axis: Axis, at : Double) {
//        let position: PositionOnAxis = at == axis.lowerBound 
//        ? .min
//        : at == axis.bounds.upperBound 
//        ? .max
//        : .number(at)
//        self = Self(on: axis, position: position)
//    }
//}

public extension AxisCoordinate {
    var bounds: ClosedRange<Double> {
        get {axis.bounds}
        set {axis.bounds = newValue}
    }
    
    var at: Double {
        get {
            switch position {
            case .max: 
                return bounds.upperBound
            case .min: 
                return bounds.lowerBound
            case .number(let a): 
                return a
            }
        }
        set {
            if newValue == bounds.upperBound {position = .max}
            else if newValue == bounds.lowerBound {position = .min}
            else {position = .number(newValue)}
        }
    }
}

public extension AxisCoordinate {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.axis.name == rhs.axis.name && lhs.at == rhs.at
    }
    
    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.axis == rhs.axis 
        && lhs.at < rhs.at
    }
    
}

public extension AxisCoordinate {
    var description: String {
        "\(axis.name) at \(position)"
    }
}
