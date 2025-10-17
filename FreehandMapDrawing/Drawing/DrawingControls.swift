//
//  DrawingControls.swift
//  FreehandMapDrawing
//
//  Created by Jeremy Barger on 10/15/25.
//

import SwiftUI

struct DrawingControls: View {
    @Binding var drawMode: DrawMode
    let onClear: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                ModeButton(
                    title: "Line",
                    isSelected: drawMode == .line,
                    color: .red
                ) {
                    drawMode = .line
                }
                
                ModeButton(
                    title: "Polygon",
                    isSelected: drawMode == .polygon,
                    color: .blue
                ) {
                    drawMode = .polygon
                }
                
                Spacer()
                
                Button(action: onClear) {
                    Image(systemName: "trash")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            .background(Color.white.opacity(0.9))
            
            Spacer()
            
            Text("Drag to draw on map")
                .padding()
                .background(Color.black.opacity(0.7))
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
        }
    }
}

