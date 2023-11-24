//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 23/11/2023.
//

import Foundation
public extension HyperValue {
    var isInterpolated: Bool {
        if internalAxes.indexOf(coordinates: valueCoordinates) != nil {
            return false
        }
        return !corrections.map{$0.coordinates}.contains(valueCoordinates)
    }
}
