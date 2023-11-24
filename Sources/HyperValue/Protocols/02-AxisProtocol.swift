//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 03/11/2023.
//

import Foundation


public protocol AxisProtocol:  Comparable & Hashable {
    
    //associatedtype CU: BinaryFloatingPoint & Codable
    ///Name of an axis. For color space could be **green**, for font space could be **width** etc
    var name: String {get set}
    ///Upper bound of axis hypercube side. For color space could be `0.0...1.0` or `0...255`, for font `0...1000`
    var upperBound: Double {get set}
    ///Lower bound of axis hypercube side
    var lowerBound: Double {get set}
    
    init(name: String, bounds: ClosedRange<Double>)
}


extension AxisProtocol {
    public var description: String {
        return "\(Self.self) \"\(name)\" (\(lowerBound)...\(upperBound))"
    }
}
