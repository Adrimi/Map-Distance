//
//  FakeAnnotations.swift
//  Map DistanceTests
//
//  Created by adrian.szymanowski on 12/06/2020.
//

import Foundation
import MapKit

#if DEBUG
extension MKPointAnnotation {
    static var fake1: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = .init(latitude: 51.5, longitude: -0.13)
        return annotation
    }
    
    static var fake2: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "Warsaw"
        annotation.subtitle = "Home to the UEFA Euro 2012."
        annotation.coordinate = .init(latitude: 52.13, longitude: 21.0)
        return annotation
    }
}
#endif
