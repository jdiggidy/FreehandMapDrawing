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
    let onDelete: (DrawnShape.ShapeType) -> Void
    
    var body: some View {
        VStack {
            HStack {
                ModeButton(
                    title: "Map",
                    isSelected: drawMode == .none,
                    color: .green) {
                        drawMode = .none
                    }
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
                
                Menu {
                    Button(role: .destructive) {
                        onDelete(.line)
                    } label: {
                        Label("Delete Lines", systemImage: "line.diagonal")
                    }
                    
                    Button(role: .destructive) {
                        onDelete(.polygon)
                    } label: {
                        Label("Delete Polygons", systemImage: "square")
                    }
                    
                    Divider()
                    
                    Button(role: .destructive) {
                        onClear()
                    } label: {
                        Label("Delete All", systemImage: "trash.fill")
                    }
                } label: {
                    Image(systemName: "trash")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                } primaryAction: {
                    // This allows long press, but you can also just tap to open menu
                }
            }
            .padding()
            .background(Color.white.opacity(0.9))
            
            Spacer()
            
            HStack {
                Image(systemName: statusIcon)
                    .foregroundColor(.white)
                Text(statusText)
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.black.opacity(0.7))
            .cornerRadius(10)
            .padding()
        }
    }
    
    private var statusText: String {
        switch drawMode {
        case .none:
            return "Map mode - pan and zoom"
        case .line:
            return "Drawing lines - drag to draw"
        case .polygon:
            return "Drawing polygons - drag to draw"
        }
    }
    
    private var statusIcon: String {
        switch drawMode {
        case .none:
            return "map"
        case .line:
            return "line.diagonal"
        case .polygon:
            return "square"
        }
    }
}

