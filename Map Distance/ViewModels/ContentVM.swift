//
//  ContentVM.swift
//  Map Distance
//
//  Created by adrian.szymanowski on 12/06/2020.
//

import Combine
import MapKit

class ContentVM: ObservableObject {
    
    let textFieldsPlaceholder = "Coord/Name"
    
    @Published var from: String = ""
    @Published var to: String = ""
    
    @Published var fromCoordinate: MKPointAnnotation?
    @Published var toCoordinate: MKPointAnnotation?
    
    func serachForLocations() {
        if let coord1 = parseStringToCoords(string: from) {
            fromCoordinate = {
                let annotation = MKPointAnnotation()
                annotation.coordinate = coord1
                return annotation
            }()
        } else {
            fromCoordinate = .none
        }
        
        if let coord2 = parseStringToCoords(string: to) {
            toCoordinate = {
                let annotation = MKPointAnnotation()
                annotation.coordinate = coord2
                return annotation
            }()
        } else {
            toCoordinate = .none
        }
        
    }
    
    func parseStringToCoords(string: String) -> CLLocationCoordinate2D? {
        let cords = string.split(separator: .init(" ")).compactMap({ Double($0) })
        if let lat = cords.first, let lon = cords.last {
            return .init(latitude: lat, longitude: lon)
        }
        return .none
    }
    
}
