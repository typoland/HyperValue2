//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 22/11/2023.
//

import Foundation
public struct CornerContainer<D>: CornerProtocol 
where D : IntepolableProtocol 
{
    public typealias Interpolable = D
    
    public init() {
        self.data = D()
        self.strength = .corner
    }
    
    public init(value: D) {
        self.data = value
        self.strength = .corner
    }
    
    public let id = UUID()
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    public var data: D
        
    public var strength: InterpolableStrength
}

extension CornerContainer: CustomStringConvertible{}

public extension CornerContainer {
    static func == (lhs:Self, rhs: Self) -> Bool {
        rhs.data == lhs.data && lhs.strength == rhs.strength
    }
}


//import Foundation
//public protocol CornerContainer {
//    associatedtype Interpolable: IntepolableProtocol
//    var data: Interpolable {get set}
//    var strength: InterpolableStrength {get set}
//}

extension CornerContainer: Hashable, Equatable {
    /// Type of data which vertex contains. Must be ``IntepolableProtocol`` to be interpolated
    //init ()
    ///Internally counted strength of vertex ``InterpolableStrength`` or `0` for corners and `1` for corrections
    //var strength: InterpolableStrength {get set}
    /// ``Interpolable`` interpolatable object for coordinates of this vertex. Inerpolated object lays somewhere between vertices
    
}



extension CornerContainer {
    init (value: D, strength: InterpolableStrength = .corner) {
        self.init()
        self.data = value
        self.strength = strength
    }
}

extension CornerContainer {
    func getCoordinates<C:CoordinateProtocol>(in axes:[C.Axis], 
                                                   index:Int, 
                                                   as: C.Type) -> [C] {
        axes.coordinatesOfCorner(index: index, as: C.self)
    }
}


extension CornerContainer {
    public var description: String {
        return "\(strength) \(Interpolable.self) \(data) "
    }
}

