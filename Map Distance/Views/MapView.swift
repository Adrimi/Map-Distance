//
//  MapView.swift
//  Map Distance
//
//  Created by adrian.szymanowski on 10/06/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    
    // MARK: - Paramters
    @Binding var fromCoordinate: MKPointAnnotation?
    @Binding var toCoordinate: MKPointAnnotation?
    @Binding var toggleUpdate: Bool
    
    private var coordsAsAnnotations: [MKPointAnnotation] {
        get {
            var annotations = [MKPointAnnotation]()
            if let coord1 = fromCoordinate {
                annotations.append(coord1)
            }
            if let coord2 = toCoordinate {
                annotations.append(coord2)
            }
            return annotations
        }
    }
    
    // MARK: - Methods
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        if toggleUpdate {
            view.removeAnnotations(view.annotations)
            view.showAnnotations(view.annotations, animated: true)
            toggleUpdate = false
        }
        
        let annotations = coordsAsAnnotations
        if annotations.map(\.coordinate) != view.annotations.map(\.coordinate) {
            view.removeAnnotations(view.annotations)
            view.showAnnotations(annotations, animated: true)
            let geodesic = MKGeodesicPolyline(coordinates: annotations.map(\.coordinate), count: annotations.count)
            view.removeOverlays(view.overlays)
            view.addOverlay(geodesic)        
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let polylineRenderer = MKPolylineRenderer(overlay: polyline)
                polylineRenderer.strokeColor = UIColor.init(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
                polylineRenderer.lineWidth = 3
                return polylineRenderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
        
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}


