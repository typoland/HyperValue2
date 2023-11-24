//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 03/11/2023.
//

import Foundation


public enum PositionOnAxis: Hashable, Equatable, Codable

{
    
    case min
    case max
    case number(Double)
    
    enum Errors: Error {
        case unknownLabel(String)
        case unknownError(Decoder)
    }
    
    public init<A>(axis: A, at: Double)
    where A: AxisProtocol
    {
        switch at {
        case let i where i == axis.lowerBound: self = .min
        case let i where i == axis.upperBound: self = .max   
        default: self = .number(at)
        }
    }
    
    public init(from decoder: Decoder) throws {
        if let number = try? decoder.singleValueContainer().decode(Double.self) {
            self = .number(number)
        }
        else {
            if let label = try? decoder.singleValueContainer().decode(String.self) {
                switch label {
                case "min": self = .min
                case "max": self = .max
                default: throw Errors.unknownLabel(label)
                }
            }
            else {
                throw Errors.unknownError(decoder)
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .number(let number):
            try container.encode(number)
        case .max:
            try container.encode("max")
        case .min:
            try container.encode("min")
        }
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.min, .min):
            return true
        case (.max, .max):
            return true
        case (number(let a), number(let b)):
            return a == b
        default:
            return false
        }
    }
    
//    public static func < (lhs: Self, rhs:Self) -> Bool {
//        switch (lhs, rhs) {
//        case (.min, .number) : return true
//        case (.min, .max)    : return true   
//        case (.number, .max) : return true
//        default: return false
//        }
//    }
}

extension PositionOnAxis: CustomStringConvertible 
{
    public var description: String {
        switch self {
        case .max: return "▲ max"
        case .min: return "▽ min"
        case .number(let x): return "\(String(format: "%.1f", Double(x)))"
        }
    }
}
