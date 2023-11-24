//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 16/11/2023.
//

import Foundation
#if DEBUG
var printInterpolateFromCacheDetails: Bool = false
#endif

extension SpaceInterpolableContainer {
    /// Creates vertex with coordinates, interpolated in delivered axes space
    /// - Parameters:
    ///   - corners: corners with data to interpolate
    ///   - coordinates: where vertex  will be interpolated
    /// - Returns:Vertex with coordinates
    init(from corners : [any CornerProtocol], 
         at coordinates : [Coordinate],  
         in smallAxes: [Coordinate.Axis] = [])
    {
        //typealias Interpolable = Interpolable
        var resultCornersInterpolable :     [Interpolable]   = corners.map{$0.data as! Interpolable} 
        var resultCornersStrength : [Double] = corners.map{$0.strength.value}

        let smallAxes = smallAxes.isEmpty ? coordinates.map { $0.axis } : smallAxes
        
        for (axisNr, coordinate) in coordinates.enumerated() {
            let arrayCount = resultCornersInterpolable.count
            var newInterpolable = [Interpolable]()
            var newStrength = [Double]()
            for l in 0 ..< (arrayCount / 2) { // >> means divide by 2, there are only powers of 2

                let indexA = l*2
                let indexB = l*2 + 1
                
                let aInterpolable = resultCornersInterpolable[indexA]
                let bInterpolable = resultCornersInterpolable[indexB]
                
                let interpolatedInterpolable = interpolateInterpolable(aInterpolable, 
                                                       with: bInterpolable, 
                                                       in: smallAxes[axisNr].bounds, 
                                                       at: coordinate.at)
                
                
                let upperBound = coordinate.axis.upperBound
                let lowerBound = coordinate.axis.lowerBound 
                
                let here = coordinate.at
                
                let strengthProportions = upperBound != lowerBound
                ? (here - lowerBound ) / (upperBound - lowerBound)
                : 1
                
                let aStrength = resultCornersStrength[indexA]
                let bStrength = resultCornersStrength[indexB]
                 

                let intrpolatedStrength = linearInterpolation (
                    between: aStrength,
                    and: bStrength,
                    in : 0.0...1.0,
                    at: strengthProportions)

                newInterpolable.append(interpolatedInterpolable)
                newStrength.append(intrpolatedStrength)
            }

            resultCornersInterpolable = newInterpolable
            resultCornersStrength = newStrength
        }
        
        let strengh = resultCornersStrength.first ?? Double.nan
        let data =  resultCornersInterpolable.first ?? Interpolable()   
        self = Self(value: data, 
                    at: coordinates, 
                    strength: InterpolableStrength(rawValue: strengh))
    }
}

