//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 23/11/2023.
//

import Foundation
func + <I:IntepolableProtocol>(lhs:I, rhs:I) -> I {
    return I(atoms: zip(lhs.atomized, rhs.atomized).map {$0 + $1})
}
///substract of atomized values of Objects
func - <I:IntepolableProtocol>(lhs:I, rhs:I) -> I {
    return I(atoms: zip(lhs.atomized, rhs.atomized).map {$0 - $1})
}
