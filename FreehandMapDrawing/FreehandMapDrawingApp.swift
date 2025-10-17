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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
