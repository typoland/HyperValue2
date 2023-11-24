//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 18/11/2023.
//

import Foundation
#if DEBUG
//var valueCounter = 0
#endif
extension HyperValue {
    static func join(corrections: [Correction],
                     in worldCorners: [any CornerProtocol],
                     on coordinates: [Coordinate],
                     cachedSpaces: inout [Correction: [SubSpace<Coordinate.Axis>]]) -> Correction 
    {
        var layers:[Correction] = []
        for correction in corrections {
            let vertex = Self.interpolateVertex(for: correction,
                                                in: worldCorners, 
                                                on: coordinates,
                                                cachedSpaces: &cachedSpaces)
            layers.append(vertex)
        }
        return layers.mixVertices 
    }
}
