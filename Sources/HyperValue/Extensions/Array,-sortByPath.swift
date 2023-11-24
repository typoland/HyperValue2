//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 23/11/2023.
//

import Foundation
extension Array where Element: Comparable {
    ///Sorts target array by self order. self elements must be available on key path of target array objects
    func sort<Target>(array target: [Target],
                      by keyPath: KeyPath<Target, Element>) -> [Target]
    {
        return self.map { element in
            target.filter({$0[keyPath: keyPath] == element}).first
        }.compactMap{$0}
    }
}
