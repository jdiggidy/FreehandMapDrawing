//
//  DrawableMapView.swift
//  FreehandMapDrawing
//
//  Created by Jeremy Barger on 10/15/25.
//

import SwiftUI

struct DrawableMapView: View {
    @State private var viewModel = MapDrawingViewModel()
    
    var body: some View {
        ZStack {
            MapboxMap(
                drawMode: $viewModel.drawMode,
                mapView: $viewModel.mapView
            )
                
            DrawingOverlay(
                drawnShapes: viewModel.drawnShapes,
                currentDrawPoints: viewModel.currentDrawPoints,
                drawMode: viewModel.drawMode,
                currentStrokeColor: viewModel.currentStrokeColor,
                currentFillColor: viewModel.currentFillColor,
                currentLineWidth: viewModel.lineWidth,
                mapView: viewModel.mapView
            )
            
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
                onClear: viewModel.clearShapes,
                onDelete: viewModel.deleteShape
            )
        }
        .background(
            GeometryReader { geo in
                Color.clear.onAppear {
                    viewModel.mapSize = geo.size
                }
            }
        )
    }
}

#Preview {
    DrawableMapView()
}
