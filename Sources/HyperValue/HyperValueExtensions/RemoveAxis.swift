//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 23/11/2023.
//

import Foundation
public extension HyperValue {
func remove(axis: Axis) async {
    
    //Interpolate at removed axis coordinate
    let removedAxisPosition = axis.position
    guard let axisIndex =  internalAxes.firstIndex(of: axis) else { return }
    
    var leftAxes = Array(internalAxes)
    
    let removedAxis = leftAxes.remove(at: axisIndex)
    
    var newVertices : [any CornerProtocol] = []
    
    func deep(coordinates: [Correction.Coordinate], axisNr: Int = 0) {
        if axisNr < leftAxes.count {
            
            deep(coordinates: coordinates 
                 + [Correction.Coordinate(on: leftAxes[axisNr], 
                                          position: .min)], 
                 axisNr: axisNr + 1)
            deep(coordinates: coordinates 
                 + [Correction.Coordinate(on: leftAxes[axisNr], 
                                          position: .max)], 
                 axisNr: axisNr + 1)
            
        } else {
            
            let renderAt = coordinates + [Correction.Coordinate(on: removedAxis, 
                                                                position: removedAxisPosition)]
            let sortedCoords = internalAxes.sort(array: renderAt, by: \.axis)
            var newVertex =  Correction(from: corners, at: sortedCoords)  //interpolatedVertex(at: sortedCoords)
            newVertex.coordinates = coordinates
            newVertices.append(newVertex)
        }
    }
    
    deep(coordinates: Array<Correction.Coordinate>())
    
    self.corners = newVertices
    self.internalAxes = leftAxes
}
}
