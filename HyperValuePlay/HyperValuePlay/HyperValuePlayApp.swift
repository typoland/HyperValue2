//
//  CombinePlayApp.swift
//  CombinePlay
//
//  Created by Łukasz Dziedzic on 02/11/2023.
//

import SwiftUI
import HyperValue

@main
struct HyperValuePlayApp: App {
    var body: some Scene {
       
        WindowGroup {
            ContentView<Color, MyAxis>()
        }
    }
}
