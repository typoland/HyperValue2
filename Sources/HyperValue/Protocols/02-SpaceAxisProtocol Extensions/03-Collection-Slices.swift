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
    /// Returns array of Coordinates  which values are taken from common axis bounds and corrections position on this axis
    /// So: it coverts axis( lowerBound...upperBound) to... wtf?
    /// - Parameters:
    ///   - axisNr: index of axis
    ///   - corrections: list of corrections coordinates 
    /// - Returns: list of coordinates of particular axis 
    /// As input could be few corrections coordinates, as an output is a list of coordinates belongs to one axis
    /// `[[1,2,3], [4,5,6], [7,8,9]]`
    /// generates output for axis `0`:
    /// for axis `0`: `[.min, 1, 4, 7, .max]`
    /// for axis `1`: `[.min, 2, 5, 8, .max]`
    /// for axis `2`: `[.min, 3, 6, 9, .max]`
    func slices<Coordinate>(for axisNr: Int,
                            dividers corrections: [[Coordinate]]) -> [Coordinate]
    where Coordinate: CoordinateProtocol,
          Element == Coordinate.Axis
    {
        var cuts: Set<Coordinate> = []
        let axis = self[axisNr]
        cuts.insert(Coordinate(on: axis, at: axis.lowerBound))
        corrections.forEach { cuts.insert($0 [axisNr]) }
        cuts.insert(Coordinate(on: axis, at: axis.upperBound))
        return [Coordinate](cuts).sorted(by: {$0 < $1})
    }
}
