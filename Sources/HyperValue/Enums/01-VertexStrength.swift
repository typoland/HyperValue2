//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 23/11/2023.
//

import Foundation

public enum InterpolableStrength: Hashable {
    case corner
    case correction
    case any(Double)
    
    init (rawValue number: Double) {
        if number == 0 {self = .corner}
        else if number == 1 {self = .correction}
        else {self = .any(number)
        }
    }
    
    var value: Double {
        switch self {
        case .corner: {return 0.0}()
        case .correction: {return 1.0}()    
        case .any(let value): {return value}()
        }
    }
    
    public static func == (lhs:Self, rhs:Self) -> Bool {
        lhs.value == rhs.value
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}

extension InterpolableStrength: CustomStringConvertible {
    var s:String {
        switch self {
        case .corner: return "⬜︎"
        case .correction: return "⬛︎"
        case .any(let number): return "⚫︎\(number.formatted(.number.precision(.fractionLength(2...2))))"
        }
    }
    public var description: String {
        "\(s)"
    }
}
//public typealias InterpolableStrength = Double
//extension InterpolableStrength : BinaryFloatingPoint {
//    static var corner = 0.0
//    static var correction = 1.0
//}
