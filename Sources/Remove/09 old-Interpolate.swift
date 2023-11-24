//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 03/11/2023.
//

import Foundation

//extension Array where Element: AxisProtocol  {
//    
//    func interpolate<InterpolableVertex>(
//        _ coordinates: [InterpolableVertex.Coordinate],
//        corners:[InterpolableVertex],
//        dimension: Int = 0) -> InterpolableVertex
//    
//    where InterpolableVertex: CorrectionProtocol,
//          InterpolableVertex.Coordinate.Axis == Element
//
//    {
//        assert( !corners.isEmpty )
//        typealias Coordinates = [InterpolableVertex.Coordinate]
//        //What about if there is just correction?
//        guard cornersCountForThisSpace == corners.count else {
//            fatalError("Wrong corners number (\(corners.count)) for \(self.count) dimensions")
//        }
//        
//        //print ("\t\t===================== RENDER NOT CORRECTED \(self) \(corners)======================")
//        let axisNr = dimension % dimensions
//        func searchVertexFor(_ coordinates: Coordinates) -> InterpolableVertex {
//            guard let vertex = (corners).filter ({corner in
//                return corner.coordinates == coordinates}).first
//            else {
//                return interpolate(coordinates, corners: corners, dimension: dimension + 1)
//            }
//            return vertex
//            
//        }
//        let lowerBound  = self[axisNr].lowerBound
//        let higherBound = self[axisNr].upperBound
//        let here = coordinates[axisNr].at
//        
//        var lowerCoordinates = coordinates
//        var upperCoordinates = coordinates
//        
//        lowerCoordinates[axisNr].at = lowerBound
//        upperCoordinates[axisNr].at = higherBound
//        
//        let  lowerVertex = searchVertexFor(lowerCoordinates)
//        let  upperVertex = searchVertexFor(upperCoordinates)
//        
//        let value = interpolateInterpolable(
//            lowerVertex.data,
//            with: upperVertex.data,
//            in: lowerVertex.coordinates[axisNr].at...upperVertex.coordinates[axisNr].at,
//            at: coordinates[axisNr].at)
//        
//        let strengthProportions = higherBound != lowerBound 
//        ? (higherBound - here) / (higherBound - lowerBound)
//        : higherBound == here ? 1.0 : 0.0
//        
//        let intrpolatedStrength = linearInterpolation(
//            between: upperVertex.strength.value,
//            and: lowerVertex.strength.value,
//            in : 0.0...1.0,
//            at: strengthProportions)
//        
//        let strength: InterpolableStrength = InterpolableStrength.init(rawValue: intrpolatedStrength)
//        
//        let interpolatedVertex =  InterpolableVertex (
//            value: value,
//            at: coordinates,
//            strength: strength)
//        
//        return interpolatedVertex
//    }
//}
