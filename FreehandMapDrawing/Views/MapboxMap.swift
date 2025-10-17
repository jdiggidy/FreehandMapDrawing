//
//  MapboxMap.swift
//  FreehandMapDrawing
//
//  Created by Jeremy Barger on 10/17/25.
//

import SwiftUI
import MapboxMaps

struct MapboxMap: View {
    @Binding var drawMode: DrawMode
    @Binding var mapView: MapView?
       
       var body: some View {
           MapLayer(mapView: $mapView, drawMode: drawMode)
       }
}

//#Preview {
//    MapboxMap()
//}
