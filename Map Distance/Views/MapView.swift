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
            view.showAnnotations(annotations, animated: true)
        } else if !annotations.isEmpty {
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
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
//            parent.centerCoordinate = mapView.centerCoordinate
        }
    }
}


#if DEBUG
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(fromCoordinate: .constant(.coord1), toCoordinate: .constant(.coord2))
    }
}

private extension MKPointAnnotation {
    static var coord1: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = .init(latitude: 51.5, longitude: -0.13)
        return annotation
    }
    
    static var coord2: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "Warsaw"
        annotation.subtitle = "Home to the UEFA Euro 2012."
        annotation.coordinate = .init(latitude: 52.13, longitude: 21.0)
        return annotation
    }
}
#endif
