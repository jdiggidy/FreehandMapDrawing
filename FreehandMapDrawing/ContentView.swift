//
//  ContentView.swift
//  FreehandMapDrawing
//
//  Created by jeffypoo on 10/7/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext

    var body: some View {
        DrawableMapView()
    }

}

#Preview {
    ContentView()
}
