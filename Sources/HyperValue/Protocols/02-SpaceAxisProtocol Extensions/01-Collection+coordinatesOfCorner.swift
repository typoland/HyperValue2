//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 23/11/2023.
//

import Foundation
public extension Collection
where Element: AxisProtocol
{
    /// Returns `coordinates` of space corner.
    /// - Parameters:
    ///   - index: index of  corner
    ///   - as: `SpaceCoordinateProtocol` type
    /// - Returns: array of coordinates.
    func coordinatesOfCorner<C>(index: Int,
                                as: C.Type) -> [C]
    where C: CoordinateProtocol,
          Element == C.Axis
    {
        var result: [C] = []
        for (axisIndex, axis) in self.enumerated() {
            let mask = 1<<axisIndex
            let val: PositionOnAxis = mask & index != 0 ? .max : .min
            result.append(C(on: axis, position: val))
        }
        return result
    }
    
}
