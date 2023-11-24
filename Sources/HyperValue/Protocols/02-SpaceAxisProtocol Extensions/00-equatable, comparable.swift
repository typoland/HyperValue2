//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 23/11/2023.
//

import Foundation
public extension AxisProtocol 
{
    static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.name < rhs.name
    }
}

public func == <Axis: AxisProtocol>(lhs: Axis, rhs: Axis) -> Bool 
{
    return lhs.name == rhs.name //&& lhs.bounds == rhs.bounds
}
