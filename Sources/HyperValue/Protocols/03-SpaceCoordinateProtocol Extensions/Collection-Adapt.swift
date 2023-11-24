//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 23/11/2023.
//

import Foundation
extension Collection
where Element: CoordinateProtocol
{
    /// Convert coordinates `.max` and `.min` to axes with different bounds
    /// - Parameter axes: target axes array
    /// - Returns: new array of coordinates
    func adapt(to axes: [Element.Axis]) -> [Element] {
        var newCoordinates: [Element] = []
        for coordinate in self {
            if let axis = axes.first(where: {$0 == coordinate.axis}) {
                newCoordinates.append(Element(on: axis, at: coordinate.at))
            }
        } 
        return newCoordinates
    }
}
