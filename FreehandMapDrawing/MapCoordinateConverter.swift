//
//  MapCoordinateConverter.swift
//  FreehandMapDrawing
//
//  Created by Jeremy Barger on 10/15/25.
//

import MapboxMaps

struct MapCoordinateConverter {
    static func pointToCoordinate(_ point: CGPoint, mapView: MapView) -> CLLocationCoordinate2D? {
        return mapView.mapboxMap.coordinate(for: point)
    }
    
    static func coordinateToPoint(_ coordinate: CLLocationCoordinate2D, mapView: MapView) -> CGPoint? {
        return mapView.mapboxMap.point(for: coordinate)
    }
}
