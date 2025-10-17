//
//  DrawShape.swift
//  FreehandMapDrawing
//
//  Created by Jeremy Barger on 10/14/25.
//

import SwiftUI
import MapboxMaps
import SwiftData

@Model
class DrawnShape {
    @Attribute(.unique) var id: UUID
    var coordinatesData: Data
    var shapeType: String
    var strokeColorData: Data
    var fillColorData: Data?
    var lineWidth: Double
    
    init(coordinates: [CLLocationCoordinate2D], type: ShapeType, strokeColor: Color, fillColor: Color?, lineWidth: CGFloat) {
        self.id = UUID()
        self.coordinatesData =  Self.encodeCoordinates(coordinates)
        self.shapeType = type == .line ? "line" : "polygon"
        self.strokeColorData = Self.encodeColor(strokeColor)
        self.fillColorData = fillColor.map { Self.encodeColor($0) }
        self.lineWidth = lineWidth
    }
    
    var coordinates: [CLLocationCoordinate2D] {
        Self.decodeCoordinates(coordinatesData)
    }
    
    var type: ShapeType {
        shapeType == "line" ? .line : .polygon
    }
    
    var strokeColor: Color {
        Self.decodeColor(strokeColorData)
    }
    
    var fillColor: Color? {
        fillColorData.map { Self.decodeColor($0) }
    }
    
    enum ShapeType {
        case line
        case polygon
    }
    
    private static func encodeCoordinates(_ coordinates: [CLLocationCoordinate2D]) -> Data {
        let pairs = coordinates.map { [$0.latitude, $0.longitude] }
        return try! JSONEncoder().encode(pairs)
    }
    
    private static func decodeCoordinates(_ data: Data) -> [CLLocationCoordinate2D] {
        let pairs = try! JSONDecoder().decode([[Double]].self, from: data)
        return pairs.map { CLLocationCoordinate2D(latitude: $0[0], longitude: $0[1]) }
    }
    
    // Color encoding/decoding helpers
    private static func encodeColor(_ color: Color) -> Data {
        let uiColor = UIColor(color)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let components = [red, green, blue, alpha]
        return try! JSONEncoder().encode(components)
    }
    
    private static func decodeColor(_ data: Data) -> Color {
        let components = try! JSONDecoder().decode([CGFloat].self, from: data)
        return Color(red: components[0], green: components[1], blue: components[2], opacity: components[3])
    }
}

enum DrawMode {
    case none
    case line
    case polygon
}
