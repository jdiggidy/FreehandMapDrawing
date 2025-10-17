//
//  DrawingControls.swift
//  FreehandMapDrawing
//
//  Created by Jeremy Barger on 10/15/25.
//

import SwiftUI

struct DrawingControls: View {
    @Binding var drawMode: DrawMode
    @Binding var lineStrokeColor: Color
    @Binding var polygonStrokeColor: Color
    @Binding var polygonFillColor: Color
    @Binding var lineWidth: CGFloat
    let onClear: () -> Void
    let onDelete: (DrawnShape.ShapeType) -> Void
    
    @State private var showStyleOptions = false
    
    var body: some View {
        VStack {
            HStack {
                ModeButton(
                    title: "Map",
                    isSelected: drawMode == .none,
                    color: .green
                ) {
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
                
                Button {
                    showStyleOptions.toggle()
                } label: {
                    Image(systemName: "paintbrush.fill")
                        .padding()
                        .background(showStyleOptions ? Color.purple : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                
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
            
            // style options
            
            if showStyleOptions {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Style Options")
                        .font(.headline)
                        .padding(.bottom, 4)
                    
                    if drawMode == .line {
                        HStack {
                            Text("Line Color:")
                            Spacer()
                            ColorPicker("", selection: $lineStrokeColor)
                                .labelsHidden()
                        }
                    }
                    
                    if drawMode == .polygon {
                        HStack {
                            Text("Stroke Color:")
                            Spacer()
                            ColorPicker("", selection: $polygonStrokeColor)
                                .labelsHidden()
                        }
                        
                        HStack {
                            Text("Fill Color:")
                            Spacer()
                            ColorPicker("", selection: $polygonFillColor)
                                .labelsHidden()
                        }
                    }
                    
                    if drawMode != .none {
                        VStack(alignment: .leading) {
                            Text("Line Width: \(Int(lineWidth))px")
                            Slider(value: $lineWidth, in: 1...10, step: 1)
                        }
                    }
                }
                .padding()
                .background(Color.white.opacity(0.95))
                .cornerRadius(10)
                .padding(.horizontal)
                .transition(.move(edge: .top).combined(with: .opacity))
            }
            
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
        .animation(.easeInOut, value: showStyleOptions)
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

