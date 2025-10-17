//
//  DrawingFunctions.swift
//  FreehandMapDrawing
//
//  Created by Jeremy Barger on 10/15/25.
//

import MapboxMaps
import SwiftUI

struct DrawingFunctions {
    static func createPath(from points: [CGPoint]) -> Path {
        guard points.count > 1 else { return Path() }
        
        var path = Path()
        path.move(to: points[0])
        
        for point in points.dropFirst() {
            path.addLine(to: point)
        }
        
        return path
    }
    
    static func createPolygonPath(from points: [CGPoint]) -> Path {
        guard points.count > 2 else { return Path() }
        
        var path = Path()
        path.move(to: points[0])
        
        for point in points.dropFirst() {
            path.addLine(to: point)
        }
        
        path.closeSubpath()
        return path
    }
    
    static func drawLine(
        context: GraphicsContext,
        points: [CGPoint],
        color: Color = .blue,
        lineWidth: CGFloat = 3
    ) {
        let path = createPath(from: points)
        context.stroke(path, with: .color(color), lineWidth: lineWidth)
    }
    
    static func drawPolygon(
        context: GraphicsContext,
        points: [CGPoint],
        fillColor: Color = .blue.opacity(0.3),
        strokeColor: Color = .blue,
        lineWidth: CGFloat = 3
    ) {
        let path = createPolygonPath(from: points)
        context.fill(path, with: .color(fillColor))
        context.stroke(path, with: .color(strokeColor), lineWidth: lineWidth)
    }
}
