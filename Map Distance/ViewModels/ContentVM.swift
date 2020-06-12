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
    
    @Published var from: String = "51 21"
    @Published var to: String = "52 21"
    
    @Published var fromAnnotation: MKPointAnnotation?
    @Published var toAnnotation: MKPointAnnotation?
    
    var distance: Double = 0
    @Published var isShowingDistanceInfo: Bool = false
    
    @Published var mapUpdate: Bool = false
    
    func serachForLocations() {
        if let coord1 = parseStringToCoords(string: from) {
            setAnnotation(&fromAnnotation, with: coord1)
        } else {
            fromAnnotation = .none
        }
        
        if let coord2 = parseStringToCoords(string: to) {
            setAnnotation(&toAnnotation, with: coord2)
        } else {
            toAnnotation = .none
        }
    }
    
    func checkDistance() {
        if let coord1 = fromAnnotation?.coordinate,
            let coord2 = toAnnotation?.coordinate {
            let distance = MKMapPoint(coord1).distance(to: MKMapPoint(coord2))
            self.distance = distance
            isShowingDistanceInfo = true
        } else {
            isShowingDistanceInfo = false
        }
    }
    
    func parseStringToCoords(string: String) -> CLLocationCoordinate2D? {
        let cords = string.split(separator: .init(" ")).compactMap({ Double($0) })
        if let lat = cords.first, let lon = cords.last {
            return .init(latitude: lat, longitude: lon)
        }
        return .none
    }
    
    func updateMap() {
        mapUpdate = true
    }
    
    // MARK: - Helper Methods
    private func setAnnotation(_ annotation: inout MKPointAnnotation?, with coordinate: CLLocationCoordinate2D) {
        annotation = MKPointAnnotation()
        annotation?.coordinate = coordinate
    }
    
}
