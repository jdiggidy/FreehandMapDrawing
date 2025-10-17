//
//  MapDrawingViewModel.swift
//  FreehandMapDrawing
//
//  Created by Jeremy Barger on 10/15/25.
//

import SwiftUI
import Observation
import MapboxMaps
import SwiftData

@Observable
class MapDrawingViewModel {
    
    var currentDrawPoints: [CGPoint] = []
    var drawMode: DrawMode = .line
    var mapView: MapView?
    var mapSize: CGSize = .zero
    var modelContext: ModelContext?
    var lineStrokeColor: Color = .red
    var polygonStrokeColor: Color = .blue
    var polygonFillColor: Color = .blue.opacity(0.3)
    var lineWidth: CGFloat = 3
    
    private var isDrawing = false
    
    var currentStrokeColor: Color {
        drawMode == .line ? lineStrokeColor : polygonStrokeColor
    }
    
    var currentFillColor: Color {
        polygonFillColor
    }
    
    func handleDragChanged(_ location: CGPoint) {
        isDrawing = true
        currentDrawPoints.append(location)
    }
    
    func handleDragEnded() {
        guard currentDrawPoints.count > 1, let mapView = mapView else {
            currentDrawPoints = []
            isDrawing = false
            return
        }
        
        let coordinates = currentDrawPoints.compactMap { point in
            MapCoordinateConverter.pointToCoordinate(point, mapView: mapView)
        }
        
        guard coordinates.count > 1 else {
            currentDrawPoints = []
            isDrawing = false
            return
        }
        
        guard let context = modelContext else {
            print("No model context available")
            currentDrawPoints = []
            isDrawing = false
            return
        }
        
        let shape = DrawnShape(
            coordinates: coordinates,
            type: drawMode == .line ? .line : .polygon,
            strokeColor: currentStrokeColor,
            fillColor: drawMode == .polygon ? currentFillColor : nil,
            lineWidth: lineWidth
        )
        
        context.insert(shape)
        
        do {
            try context.save()
            print("Shape saved successfully. ID: \(shape.id)")
        } catch {
            print("Failed to save shape: \(error)")
        }
        currentDrawPoints = []
        isDrawing = false
    }
    
    func clearShapes() {
        //drawnShapes.removeAll()
    }
    
    func deleteShape(ofType type: DrawnShape.ShapeType) {
        //drawnShapes.removeAll { $0.type == type }
    }
}
