//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 15/11/2023.
//

import Foundation
extension HyperValue {
    /// Delivers calculated value at coordinates
    /// - Parameter coordinates: World coordinates
    /// - Returns: interpolated value
    /// 
    func interpolatedContainer(at coordinates: [Coordinate]) 
    -> any ContainerProtocol 
    {
        // first, trim global coordinates to local coordinates. 
        //Local values could be two-dimensional, global 32-dimensional (too slow, max 8 please
        let localCoordinates = coordinates.trimmed(to: internalAxes)
        
        guard !localCoordinates.isEmpty else { 
            return corners[0] as (any ContainerProtocol)
        }
        
        //If coordinates don't need interpolation - return vertex - corner or correction
        if let cornerIndex = internalAxes.indexOf(coordinates: coordinates) {
            return corners[cornerIndex] as (any ContainerProtocol)
        }
        
        
        if let vertex = corrections.filter({$0.coordinates == localCoordinates}).first {
            return vertex as (any ContainerProtocol)
        }
        //If there is no corrections
        if corrections.isEmpty {
            return Correction(from: corners, at: coordinates) as (any ContainerProtocol)//danger danger
        }
        
        if cachedCoordinates == localCoordinates, let cachedValue {
            return cachedValue as (any ContainerProtocol)
        }
        
        //MARK: Corrections here

        let resultVertex = Self.join(corrections: corrections,
                                     in: corners,
                                     on: localCoordinates,
                                     cachedSpaces: &cachedCorrectionsSpaces)


        cachedCoordinates = localCoordinates
        cachedValue = resultVertex
        return cachedValue! as (any ContainerProtocol)
    }
    
}
