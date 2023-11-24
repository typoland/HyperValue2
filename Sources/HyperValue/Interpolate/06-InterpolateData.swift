//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 03/11/2023.
//

import Foundation

///Interpolates number at t between bounds.lowerBound and bounds.upperBound from `value1` and `value2`
///
///- parameters:
///     - value1: value at `bounds.lowerBound`
///     - value2: value at `bounds.upperBound`
///     - bounds: range of interpolation for parameter `t`
///     - t: value `t` in range of `bounds` where `value1` and `value2` will be interpolated
///- returns: Interpolated value
///
///**Basic example:** let `value1=5`, `value2=10`, `bounds = 0...1000` and `t = 500`. Interpolated value wil be `7,5` as a half way between `5` and `10`
///
///
///

func  linearInterpolation<Atom> (
    between  value1: Atom,
    and value2: Atom,
    in bounds:ClosedRange<Double>,
    at t: Double) -> Atom 
where Atom: BinaryFloatingPoint

{
        guard bounds.upperBound != bounds.lowerBound else {
            return value1
        }
        
        let a = (value2-value1)
        let b = (t - bounds.lowerBound)/(bounds.upperBound - bounds.lowerBound)
        
        return Atom(Double(a) * Double(b)) + value1
    }
    
    ///Interpolates ``IntepolableProtocol`` object
    /// - parameter dataA: object at `bounds.lowerBound`
    /// - parameter with: object at `bounds.upperBound`
    /// - parameter bounds: range of interpolation
    /// - parameter at: value `i` in range of `bounds`, where result object will be interpolated
    /// - returns: interpolated object
    /// 

    
func interpolateInterpolable <Interpolable> (_ dataA: Interpolable,
                          with dataB: Interpolable,
                          in bounds: ClosedRange <Double>,
                          at: Double ) -> Interpolable 
where Interpolable: IntepolableProtocol
{
    
    var resultAtoms:[Interpolable.Atom] = []
    if bounds.upperBound == bounds.lowerBound {
        return dataA
    }
    let atomsA = dataA.atomized
    let atomsB = dataB.atomized
    for (atomA, atomB) in zip ( atomsA, atomsB ) { //0..<dataA.count {
        
        let newAtom = linearInterpolation(
            between: atomA ,
            and: atomB,
            in: bounds,
            at: at)
        
        resultAtoms.append( newAtom )
    }
    return Interpolable(atoms: resultAtoms)
}

