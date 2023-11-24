//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 23/11/2023.
//

import Foundation
public extension AxisProtocol 
{
    /// same as `lowerBound...upperBound`
    var bounds: ClosedRange<Double> {
        get { lowerBound...upperBound }
        set {
            lowerBound = newValue.lowerBound
            upperBound = newValue.upperBound
        }
    }
}
