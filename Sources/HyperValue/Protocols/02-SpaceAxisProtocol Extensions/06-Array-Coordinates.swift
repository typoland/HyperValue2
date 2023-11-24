//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 23/11/2023.
//

import Foundation
extension Array
where Element: AxisProtocol,
      Element: HasCoordinateProtocol
{
    /// Actual coordinates positions in [SpaceAxis] space, if SpaceAxis conform to protocol `HasCoordinateProtocol
    ///
    /// - returns: [Coordinate]
    ///
    /// If problem make
    /// ```
    ///    var coordinates: [SomeCoordinate] =  axes.coordinates()
    /// ```
    ///   because function must know what type must return. Axis itself knows nothing about Coordinates.
    ///
    public func coordinates<C>() -> [C]
    where C : CoordinateProtocol,
          C.Axis == Element
    {
        return self.map { C(on: $0, position: $0.position) }
    }
    
    public mutating func setCoordinates<C>(_ coordinates: [C])
    where C: CoordinateProtocol,
          C.Axis == Element
    {
        for coordinate in coordinates {
            if let index = self.firstIndex(where: { coordinate.axis == $0 }) {
                self[index].position = coordinate.position
            }
        }
    }
}
