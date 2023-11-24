//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 23/11/2023.
//

import Foundation
//infix operator >*

///Multiplies `lhs` atoms of InterpolatableInterpolable by `rhs` value, returns new data``
func * <I:IntepolableProtocol> (lhs:I, rhs:I.Atom) -> I {
    return I(atoms: lhs.atomized.map {$0 * rhs})
}
