//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 23/11/2023.
//

import Foundation
public extension HyperValue {
    @inlinable
    func containAxis(_ axis:Axis) -> Bool {
        internalAxes.contains(axis) 
    }
}
