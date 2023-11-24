//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 23/11/2023.
//

import Foundation
public extension Array
where Element: AxisProtocol
{
    typealias Axis = Element
    /// returns axes with defined bounds around coordinates
    /// - Parameters:
    ///   - corrections: list of corrections in space
    ///   - coordinates: returned space will contain this coordinates 
    /// - Returns: space restricted by corrections in which coordinates could by found
    func subspaceAxes<A>(dividedBy corrections: [A], 
                         for coordinates: [A.Coordinate]) 
    //async throws
    -> [Axis]
    
    where A: CorrectionProtocol,
          Axis == A.Coordinate.Axis
    
    {
        typealias Axis = Element
        var subspaceAxes: [Element] = []
        
        /// based on corrections coordinates creates subspace axes with bounds between cuts and assigns them to **subspaceAxes** defined above
        
        func makeSubspaceAxes(axisNr: Int, renderedAxes: [Axis]) {
            if axisNr < self.count {
                let axisSlices = slices(for: axisNr, 
                                        dividers: corrections.map{$0.coordinates})
                var lowest = axisSlices.min()!
                var highest = axisSlices.max()!
                // try Task.checkCancellation()
                for cutNr in 0..<axisSlices.count - 1 {
                    let l = axisSlices[cutNr]
                    let h = axisSlices[cutNr + 1]
                    if (l...h).contains(coordinates[axisNr]) {
                        lowest = l
                        highest = h
                        break
                    }
                }
                
                let substractedAxis = Axis(name: self[axisNr].name,
                                           bounds: lowest.at...highest.at)
                makeSubspaceAxes(axisNr: axisNr + 1,
                                 renderedAxes: renderedAxes + [substractedAxis])
            } else {
                subspaceAxes = renderedAxes
            }
        }
        
        makeSubspaceAxes(axisNr: 0, renderedAxes: [])
        
        return subspaceAxes
    }
}
