//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 03/11/2023.
//

import Foundation

///Protocol for interpolated objects
///
///This framework could interpolate any objects when it's possible to convert them to an array of numbers and init back from an array of numbers.
///For example color could be splited into RGBA channels and recreated from four numbers representing RGBA values.
///
///     struct Color {
///         var r: Double
///         var g: Double
///         var b: Double
///         var a: Double
///     }
///To adapt protocol you need to add an extension
///
///     extension Color: SpaceInterpolatableProtocol {
///     
///         static var count = 4
///
///         var atomized: [Double] {
///             [r, g, b, a]
///         }
///
///         init (_ array: [Double] ) {
///             self = Color(r: array[0],
///                          g: array[1],
///                          b: array[2],
///                          a: array[3])
///         }
///    }
///

//public protocol InterpolableAtomProtocol : BinaryFloatingPoint {}

public protocol IntepolableProtocol : Equatable {
    
    ///Type of atomized values
    associatedtype Atom: BinaryFloatingPoint, Equatable
    ///Array of ``Atom`` numbers representing atomized object
    var atomized: [Atom] {get}
    
    ///Constant length of atomized object. Necessary to create new object from nothing
    static var atomsCount: Int {get}
    
    //static var zero: Self {get}
    
    ///Create object from array of numbers
    init(atoms array: [Atom])
}

public extension IntepolableProtocol {
    ///Creates  *zero* object
    init () {
        self = Self.init(atoms: Array(repeating: 0, count: Self.atomsCount))
    }
}

extension IntepolableProtocol {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.atomized == rhs.atomized
    }
}

extension Array where Element: IntepolableProtocol {
    ///Average atoms in array of ``IntepolableProtocol`` objects.
    
    var average: Element {
        var resultAtoms: [Element.Atom] = []
        let inputAtoms = self.map {$0.atomized}
        for i in 0..<Element.atomsCount {
            let s = inputAtoms.reduce(into: 0.0, {$0 += $1[i]}) / Element.Atom (self.count)
            resultAtoms.append(s)
        }
        return Element(atoms: resultAtoms)
    }
}

extension Array where Element: BinaryFloatingPoint {
    ///Average atoms in array of ``BinaryFloatingPoint`` objects.
    
    var averageD: Element {
            self.reduce(into: 0.0, {$0 += $1}) / Element (self.count)
    }
}

extension Double: IntepolableProtocol {}
extension CGFloat: IntepolableProtocol {}
extension Float: IntepolableProtocol {}


extension BinaryFloatingPoint {
    
    public init(atoms array: [Self]) {
        self = array.first!
    }
    
    public var atomized: [Self] {
        [self]
    }
    
    public static var atomsCount: Int {
        1
    }
}


extension CGPoint: IntepolableProtocol {

    public typealias Atom = CGFloat
    
    public init(atoms array: [Atom]) {
        self = CGPoint(x: array[0], y: array[1])
    }
    
    public var atomized: [Atom] {
        [self.x, self.y]
    }
    
    public static var atomsCount: Int {
        2
    }
    
    
}
import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension Color: IntepolableProtocol {
    
    public typealias Atom = CGFloat
    
    public init(atoms array: [Atom]) {
        self = Color(red: array[0], green: array[1], blue: array[2], opacity: array[3])
    }
    
    public var atomized: [Atom] {
#if canImport(UIKit)
        typealias NativeColor = UIColor
#elseif canImport(AppKit)
        typealias NativeColor = NSColor
#endif

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 1
        NativeColor(self).getRed(&r, 
                                 green: &g, 
                                 blue: &b, 
                                 alpha: &a)        
        return [r, g, b, a]
    }
    
    public static var atomsCount: Int {
        4
    }
}
    



