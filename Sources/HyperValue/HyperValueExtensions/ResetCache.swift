//
//  File.swift
//  
//
//  Created by Łukasz Dziedzic on 24/11/2023.
//

import Foundation
extension HyperValue {
    func resetCache() {
        cachedCorrectionsSpaces = [:]
        cachedCoordinates = []
        cachedValue = nil
    }
}
