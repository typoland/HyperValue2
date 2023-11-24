//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 23/11/2023.
//

import Foundation
extension Array
where Element: AxisProtocol {
    /// Returns index of coordinates corner or `nil` if it does not exist
    /// - Parameter coordinates: array of  some `SpaceCoordinateProtocol`
    /// - Returns: index of corner or `nil`
    func indexOf<C>(coordinates: [C]) -> Int?
    where C: CoordinateProtocol,
          Element == C.Axis
    {
        var result: Int = 0
        for axis in self.reversed() {
            if let coordinate = coordinates.first(where: {$0.axis == axis}) {
                result = result << 1
                switch coordinate.position {
                case .number: return nil
                case .max :
                    result += 1
                default:
                    break
                }
            } 
        }
        return result
    }
}
