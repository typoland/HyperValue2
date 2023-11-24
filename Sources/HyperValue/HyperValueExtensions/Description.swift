//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 23/11/2023.
//

import Foundation
public extension HyperValue {
    var description: String {
        return "\(isInterpolated ? "○" : "●") \(value)"
    }
}
