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
            MapLayer(
                mapView: $viewModel.mapView,
                drawMode: viewModel.drawMode
            )
            
            DrawingOverlay(
                drawnShapes: viewModel.drawnShapes,
                currentDrawPoints: viewModel.currentDrawPoints,
                drawMode: viewModel.drawMode,
                mapView: viewModel.mapView
            )
            
            DrawingGestureLayer(
                onDragChanged: viewModel.handleDragChanged,
                onDragEnded: viewModel.handleDragEnded
            )
            
            DrawingControls(
                drawMode: $viewModel.drawMode,
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
