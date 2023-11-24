//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 03/11/2023.
//

import Foundation


extension  HyperValue {

    /// <#Description#>
    /// - Parameters:
    ///   - correction: coorrection vertex to divide space
    ///   - corners: data corners of space (2^dimensions)
    ///   - coordinates: coordinates to take value
    ///   - cachedSpaces: cache
    /// - Returns: `CorrectionProtocol` data vertex, interpolataed on `coordinates`
    static func interpolateVertex (
        for correction: Correction,
        in corners: [any CornerProtocol],
        on coordinates: [Correction.Coordinate],
        cachedSpaces: inout [Correction: [SubSpace<Axis>]])
    -> Correction 
    {
        
        //------------------ CHECK CACHE -------------------
        if let subspace = cachedSpaces[correction]?.first(where: {subspace in
            subspace.contains(coordinates: coordinates)
        }) {
            return Correction(from: subspace.corners, 
                              at: coordinates.adapt(to: subspace.axes),
                              in: subspace.axes)  
        }
         
        
        //------------------NO CORRECTIONS OR CORNER ALLOWED - NO SENSE
        if correction.coordinates.isCorner || correction.coordinates == coordinates {
            return correction
        }       
        //------------------------------------
        let biggerSpace = coordinates.map({$0.axis})
        //every axis upper bounds are resticted max to correction coordinates
        //New space is a space between origin and correction
        
        // ------------------FIND AXES BETWEEN CORNER and CORRECTION
        let shortenAxes =  biggerSpace.subspaceAxes(dividedBy: [correction], 
                                            for: coordinates)

        let correctionSmallSpaceCoordinates = correction
            .coordinates
            .adapt(to: shortenAxes)

        var newCorners : [any CornerProtocol] = []
        
        let indexOfCorrectionCorner = shortenAxes.indexOf(coordinates: correctionSmallSpaceCoordinates)
        

        for cornerIndex in 0..<shortenAxes.cornersCountForThisSpace {
           
            if indexOfCorrectionCorner == cornerIndex {
                let corner = Corner(value: correction.data, 
                                    strength: .correction)
                newCorners.append(corner)

            } else {
                let coordinates = shortenAxes
                    .coordinatesOfCorner(index: cornerIndex, as: Coordinate.self)
                    .adapt(to: biggerSpace)
                
                let newVertex = Correction(from: corners, 
                                           at: coordinates)

                newCorners.append(Corner(value: newVertex.data, 
                                         strength: newVertex.strength))
            }
        }

        if cachedSpaces[correction] == nil {
            cachedSpaces[correction] = []
        }
        let newSubspace = SubSpace(axes: shortenAxes, corners: newCorners)

        cachedSpaces[correction]?.append(newSubspace)
        
        let resultVertex = Correction(from: newCorners, 
                                      at: coordinates.adapt(to: shortenAxes)) 
     
        return resultVertex
    }
}

