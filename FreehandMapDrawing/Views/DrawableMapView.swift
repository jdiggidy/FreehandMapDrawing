//
//  DrawableMapView.swift
//  FreehandMapDrawing
//
//  Created by Jeremy Barger on 10/15/25.
//

import SwiftUI
import SwiftData

struct DrawableMapView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var savedShapes: [DrawnShape]
    @State private var viewModel = MapDrawingViewModel()
    
    var body: some View {
        ZStack {
            MapboxMap(
                drawMode: $viewModel.drawMode,
                mapView: $viewModel.mapView
            )
                
            DrawingOverlay(
                drawnShapes: savedShapes,
                currentDrawPoints: viewModel.currentDrawPoints,
                drawMode: viewModel.drawMode,
                currentStrokeColor: viewModel.currentStrokeColor,
                currentFillColor: viewModel.currentFillColor,
                currentLineWidth: viewModel.lineWidth,
                mapView: viewModel.mapView
            )
            .allowsHitTesting(false)
            
            DrawingGestureLayer(
                isEnabled: viewModel.drawMode != .none,
                onDragChanged: viewModel.handleDragChanged,
                onDragEnded: viewModel.handleDragEnded
            )
            .allowsHitTesting(viewModel.drawMode != .none)
            
            DrawingControls(
                drawMode: $viewModel.drawMode,
                lineStrokeColor: $viewModel.lineStrokeColor,
                polygonStrokeColor: $viewModel.polygonStrokeColor,
                polygonFillColor: $viewModel.polygonFillColor,
                lineWidth: $viewModel.lineWidth,
                onClear: {clearAllShapes()},
                onDelete: { type in deleteShapes(ofType: type) }
            )
        }
        .background(
            GeometryReader { geo in
                Color.clear.onAppear {
                    viewModel.mapSize = geo.size
                    viewModel.modelContext = modelContext
                }
            }
        )
    }
    
    private func clearAllShapes() {
        for shape in savedShapes {
            modelContext.delete(shape)
        }
    }
    
    private func deleteShapes(ofType type: DrawnShape.ShapeType) {
        let shapesToDelete = savedShapes.filter { $0.type == type }
        for shape in shapesToDelete {
            modelContext.delete(shape)
        }
    }
}

#Preview {
    DrawableMapView()
}
