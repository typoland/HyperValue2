//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 16/11/2023.
//



import Foundation
public protocol ContainerProtocol {
    associatedtype Interpolable: IntepolableProtocol
    var data: Interpolable {get set}
    var strength: InterpolableStrength {get set}
}

public protocol CornerProtocol: ContainerProtocol, Hashable, Equatable {
    /// Type of data which vertex contains. Must be ``IntepolableProtocol`` to be interpolated
    init ()
    ///Internally counted strength of vertex ``InterpolableStrength`` or `0` for corners and `1` for corrections
    //var strength: InterpolableStrength {get set}
    /// ``Interpolable`` interpolatable object for coordinates of this vertex. Inerpolated object lays somewhere between vertices

}



extension CornerProtocol {
    init (value: Interpolable, strength: InterpolableStrength = .corner) {
        self.init()
        self.data = value
        self.strength = strength
    }
}

extension CornerProtocol {
    func getCoordinates<C:CoordinateProtocol>(in axes:[C.Axis], 
                                                   index:Int, 
                                                   as: C.Type) -> [C] {
        axes.coordinatesOfCorner(index: index, as: C.self)
    }
}


extension CornerProtocol {
    public var description: String {
        return "\(strength) \(Interpolable.self) \(data) "
    }
}
