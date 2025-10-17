//
//  MapLayer.swift
//  FreehandMapDrawing
//
//  Created by Jeremy Barger on 10/15/25.
//

import SwiftUI
import MapboxMaps

extension CLLocationCoordinate2D {
    static let bozeman: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 45.676998, longitude: -111.042933)

    static let greatFalls: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 47.506187, longitude: -111.390792)
}




struct MapLayer: UIViewRepresentable {
    @Binding var mapView: MapView?
    let drawMode: DrawMode
    
    func makeUIView(context: Context) -> MapView {
        let mapView = MapView(frame: .zero)
        
        // Configure initial camera
        let cameraOptions = CameraOptions(
            center: .greatFalls,
            zoom: 12
        )
        mapView.mapboxMap.setCamera(to: cameraOptions)
        
        // Store reference in view model
        DispatchQueue.main.async {
            self.mapView = mapView
        }
        
        return mapView
    }
    
    func updateUIView(_ uiView: MapView, context: Context) {
        // Update map if needed
        let isMapMode = (drawMode == DrawMode.none)
        uiView.gestures.options.panEnabled = isMapMode
        uiView.gestures.options.pinchEnabled = isMapMode
        uiView.gestures.options.rotateEnabled = isMapMode
        uiView.gestures.options.pitchEnabled = isMapMode
    }
}

//#Preview {
//    MapLayer(viewModel: MapDrawingViewModel)
//}
