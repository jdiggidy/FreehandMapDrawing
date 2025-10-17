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
    let currentStrokeColor: Color
    let currentFillColor: Color
    let currentLineWidth: CGFloat
    let mapView: MapView?
    
    var body: some View {
        
        let _ = print("DrawMode: \(drawMode), Points: \(currentDrawPoints.count)")
        Canvas { context, size in
            guard let mapView = mapView else { return }
            
            // Draw completed shapes
            for shape in drawnShapes {
                
                let coordinates = shape.coordinates
                let shapeType = shape.type
                let strokeColor = shape.strokeColor
                let fillColor = shape.fillColor
                let lineWidth = shape.lineWidth
                
                let points = coordinates.compactMap { coord in
                    MapCoordinateConverter.coordinateToPoint(
                        coord,
                        mapView: mapView
                    )
                }
                
                guard points.count > 1 else { continue }
                
                switch shapeType {
                case .line:
                    DrawingFunctions.drawLine(
                        context: context,
                        points: points,
                        color: .red,
                        lineWidth: lineWidth
                    )
                case .polygon:
                    DrawingFunctions.drawPolygon(
                        context: context,
                        points: points,
                        fillColor: fillColor ?? .blue.opacity(0.3),
                        strokeColor: strokeColor,
                        lineWidth: lineWidth
                    )
                }
            }
            
            // Draw current shape being drawn
            if drawMode != .none && currentDrawPoints.count > 1 {
                switch drawMode {
                case .line:
                    DrawingFunctions.drawLine(
                        context: context,
                        points: currentDrawPoints,
                        color: currentStrokeColor,
                        lineWidth: currentLineWidth
                    )
                case .polygon:
                    // Need at least 3 points for a visible polygon
                    if currentDrawPoints.count > 2 {
                        DrawingFunctions.drawPolygon(
                            context: context,
                            points: currentDrawPoints,
                            fillColor: currentFillColor,
                            strokeColor: currentStrokeColor,
                            lineWidth: currentLineWidth
                        )
                    } else {
                        // Show line preview until we have 3 points
                        DrawingFunctions.drawLine(
                            context: context,
                            points: currentDrawPoints,
                            color: currentStrokeColor,
                            lineWidth: currentLineWidth
                        )
                    }
                case .none:
                    break
                }
            }
        }
        .allowsHitTesting(false)
    }
}
