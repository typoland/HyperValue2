//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 23/11/2023.
//

import Foundation
extension Array
where Element: AxisProtocol
{
    /// Creates list of coordinates for every corner of space defined by axes bounds.
    /// - Returns: coordinates for each corner
    /// In convention `[.min, .min ....] .... [.max, .max ...`]
    public func cornersCoordinates<Coordinate>() -> [[Coordinate]]
    where Coordinate : CoordinateProtocol,
          Element == Coordinate.Axis
    {
        self.vertexNumbers
            .map { self.coordinatesOfCorner(index: $0, 
                                            as: Coordinate.self) 
            }
    }
}
