//
//  DrawingOverlay.swift
//  FreehandMapDrawing
//
//  Created by Jeremy Barger on 10/15/25.
//

import SwiftUI
import MapboxMaps

struct DrawingOverlay: View {
    let drawnShapes: [DrawnShape]
    let currentDrawPoints: [CGPoint]
    let drawMode: DrawMode
    let mapView: MapView?
    
    var body: some View {
        
        let _ = print("DrawMode: \(drawMode), Points: \(currentDrawPoints.count)")
        Canvas { context, size in
            guard let mapView = mapView else { return }
            
            // Draw completed shapes
            for shape in drawnShapes {
                let points = shape.coordinates.compactMap { coord in
                    MapCoordinateConverter.coordinateToPoint(
                        coord,
                        mapView: mapView
                    )
                }
                
                guard points.count > 1 else { continue }
                
                switch shape.type {
                case .line:
                    DrawingFunctions.drawLine(
                        context: context,
                        points: points,
                        color: .red
                    )
                case .polygon:
                    DrawingFunctions.drawPolygon(
                        context: context,
                        points: points,
                        fillColor: .blue.opacity(0.3),
                        strokeColor: .blue
                    )
                }
            }
            
            // Draw current shape being drawn
            if drawMode != .none && currentDrawPoints.count > 1 {
                switch drawMode {
                case .line:
                    DrawingFunctions.drawLine(context: context, points: currentDrawPoints, color: .red)
                case .polygon:
                    // Need at least 3 points for a visible polygon
                    if currentDrawPoints.count > 2 {
                        DrawingFunctions.drawPolygon(
                            context: context,
                            points: currentDrawPoints,
                            fillColor: .blue.opacity(0.3),
                            strokeColor: .blue
                        )
                    } else {
                        // Show line preview until we have 3 points
                        DrawingFunctions.drawLine(context: context, points: currentDrawPoints, color: .blue)
                    }
                case .none:
                    break
                }
            }
        }
        .allowsHitTesting(false)
    }
}
