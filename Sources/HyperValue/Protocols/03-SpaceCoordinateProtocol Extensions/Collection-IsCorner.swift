//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 23/11/2023.
//

import Foundation
public extension Collection 
where Element: CoordinateProtocol 
{
    var isCorner: Bool {
        return self.reduce(
            into: true, { $0 = $0 && [PositionOnAxis.max, .min]
                .contains($1.position) })
    }
}
