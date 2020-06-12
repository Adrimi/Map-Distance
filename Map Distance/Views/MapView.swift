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
    var fromCoordinate: Binding<MKPointAnnotation?>
    var toCoordinate: Binding<MKPointAnnotation?>
    
    private var coordsAsAnnotations: [MKPointAnnotation] {
        get {
            var annotations = [MKPointAnnotation]()
            if let coord1 = fromCoordinate.wrappedValue {
                annotations.append(coord1)
            }
            if let coord2 = toCoordinate.wrappedValue {
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
        let annotations = coordsAsAnnotations
        if annotations.count != view.annotations.count {
            view.removeAnnotations(view.annotations)
            view.addAnnotations(annotations)
        }
        
        if !annotations.isEmpty {
            view.showAnnotations(annotations, animated: true)
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
        
    }
}

