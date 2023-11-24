//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 23/11/2023.
//

import Foundation
public extension HyperValue {
    /// Adds ``InterpolableVertexProtocol`` vertex at current coordinates.
    /// - Parameter value: `Interpolable` data
    /// Corroction will be added at current axes coordinates
    @discardableResult
    func addCorrection(_ value: Interpolable ) -> Bool {
        
        //cant add if coordinates are on corner
        if internalAxes.indexOf(coordinates: valueCoordinates) != nil {
            return false
        }
        //ad correction if there is no one on same coordinates
        if corrections.filter ({$0.coordinates == valueCoordinates}).isEmpty {
            let type: InterpolableStrength = .correction 
            corrections.append(Correction(value: value, at: valueCoordinates, strength: type))
            return true
        }
        return false
    }
    
    func removeCorrection(_ correction: Correction) {
        if let index = corrections.firstIndex(where: {$0 == correction}) {
            corrections.remove(at: index)
        }
    }
}
    
