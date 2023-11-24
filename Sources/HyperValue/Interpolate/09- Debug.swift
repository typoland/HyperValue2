//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 22/11/2023.
//

import Foundation
#if DEBUG
func printCache<T, M>(cache: [T:[SubSpace<M>]])
{
    print ("\n------------ Cache \(cache.count) elements ---------------")
    for c in cache {
        print ("|\t", c.value.count, "in", c.key )
        c.value.forEach({print ("|\t\t \($0.corners.map{$0.strength}) • \($0.axes)")})
    }
}
#endif
