//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 23/11/2023.
//

import Foundation
public extension Array where Element: AxisProtocol 
{
    
    /// Makes array of coordinates
    /// - Parameter coordinates: `Double, Double....`
    /// - Returns: array of coordinates
    /// Because `Axis` knows nothing about coordinates, you need to specify
    /// ```
    /// let coordinates = someAxes.makeCorrdinates(100,0, 200, 500) as [YourCorrdinate]
    /// ```
    func makeCoordinates<C>(_ coordinates: Double...) -> [C]
    where C: CoordinateProtocol,
          Element == C.Axis
    {
        return makeCoordinates(coordinates, as: C.self)
    }
    
    /// Makes array of coordinates
    /// - Parameter coordinates: array of doubles `[Double]`
    /// - Returns: array of coordinates
    /// Because `Axis` knows nothing about coordinates, you need to specify
    /// ```
    /// let numbers = [100,0, 200, 500]
    /// let coordinates = someAxes.makeCorrdinates(numbers) as [YourCorrdinate]
    /// ```
    func makeCoordinates<C: CoordinateProtocol>(_ coordinates: [Double], as: C.Type) -> [C]
    where Element == C.Axis
    {
        return self.enumerated().map { index, position in
            C(on: position, at: coordinates[index])
        }
    }
}
