//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 23/11/2023.
//

import Foundation
public extension Collection 
where Element: AxisProtocol {
    func canAdd(newAxis: Element?) -> Bool {
        guard let newAxis else {return false}
        return self.first{$0.name == newAxis.name} == nil
    }
}
