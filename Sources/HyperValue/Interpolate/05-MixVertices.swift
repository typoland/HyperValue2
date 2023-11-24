//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 03/11/2023.
//

import Foundation
extension Array where Element: CorrectionProtocol

{
    var mixVertices: Element
    {
        let peaks = self.map{$0.strength.value}
            //.map{pow($0,0.1)} // gamma? usefull?
            .extremaPeaks
        
        let InterpolableStrengths = self.map({ $0.data })
            .mix(with: peaks)
        
        let newVertex = Element(value: InterpolableStrengths,
                                at: self[0].coordinates,
                                strength: InterpolableStrength.correction)
        return newVertex
    }
}

extension Array where Element: BinaryFloatingPoint {
    ///Most importatnt function to render corrections. If one of elements is equal 1, rest beacame 0. Sum of all numbers in result always is 1
    var extremaPeaks : [Element]  {
        var hasNil:Bool = false
        
        let formula:(_ a:Element) -> Element? = { a in
            guard a != 1.0 else {
                hasNil = true
                return nil }
            return a/(1-a)
        }
        
        let first = self.map{ formula ($0) }
        let result = hasNil 
        ? first.map { $0 == nil ? 1 : 0 } 
        : first.map {$0!}
        
        let sum = result.reduce(0, +)
        
        return sum != 0 ?
        result.map {$0/sum} :
        Array(repeating: 1.0/Element(self.count), count: self.count)
    }
}

extension Array where Element: BinaryFloatingPoint {
    var shorts:String {
        return "[\(self.reduce ("", { $0 + String(format: "%6.2f, ", $1 as! CVarArg)} ))]"
    }
}

extension Array where Element: IntepolableProtocol {
    
    func mix<B>(with peaks:[B]) -> Element where B: BinaryFloatingPoint{
        return self.enumerated()
            .reduce(into: Element()) { newInterpolable, next in
            newInterpolable = (next.element * Element.Atom( peaks[next.offset])) + newInterpolable
        }
    }
}
