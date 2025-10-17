//
//  DrawingGestureLayer.swift
//  FreehandMapDrawing
//
//  Created by Jeremy Barger on 10/15/25.
//

import SwiftUI
struct DrawingGestureLayer: View {
    let onDragChanged: (CGPoint) -> Void
    let onDragEnded: () -> Void
    
    var body: some View {
        Color.clear
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        onDragChanged(value.location)
                    }
                    .onEnded { _ in
                        onDragEnded()
                    }
            )
    }
}
