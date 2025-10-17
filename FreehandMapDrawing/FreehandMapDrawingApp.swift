//
//  FreehandMapDrawingApp.swift
//  FreehandMapDrawing
//
//  Created by jeffypoo on 10/7/25.
//

import SwiftUI
import SwiftData

@main
struct FreehandMapDrawingApp: App {
   
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: DrawnShape.self)
    }
}
