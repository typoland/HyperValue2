//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 23/11/2023.
//

import Foundation
extension Collection 
where Element: CoordinateProtocol 
{
    func trimmed(to axes: [Element.Axis]) -> [Element] {
        self.filter { axes.contains($0.axis) }
    }
}
