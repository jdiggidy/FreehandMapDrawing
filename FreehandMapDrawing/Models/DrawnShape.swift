//
//  DrawShape.swift
//  FreehandMapDrawing
//
//  Created by Jeremy Barger on 10/14/25.
//

import SwiftUI
import MapKit

struct DrawnShape: Identifiable{
    let id = UUID()
    let coordinates: [CLLocationCoordinate2D]
    let type: ShapeType
    
    enum ShapeType {
        case line
        case polygon
    }
}

enum DrawMode {
    case line
    case polygon
}
