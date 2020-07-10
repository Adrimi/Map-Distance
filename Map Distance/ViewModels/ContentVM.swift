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
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var from: String = ""
    @Published var to: String = ""
    
    @Published var fromAnnotation: MKPointAnnotation?
    @Published var toAnnotation: MKPointAnnotation?
    
    var distance: Double = 0
    @Published var isShowingDistanceInfo: Bool = false
    
    @Published var mapUpdate: Bool = false
    
    func serachForLocations() {
        fatalError()
        if let coord1 = parseStringToCoords(string: from) {
            fromAnnotation = .init()
            setAnnotation(fromAnnotation, with: coord1)
        } else {
            fetch(location: from) { [weak self] location in
                self?.fromAnnotation = .init()
                self?.fetchHandler(location: location, annotation: self?.fromAnnotation)
            }
        }
        
        if let coord2 = parseStringToCoords(string: to) {
            toAnnotation = .init()
            setAnnotation(toAnnotation, with: coord2)
        } else {
            fetch(location: to) { [weak self] location in
                self?.toAnnotation = .init()
                self?.fetchHandler(location: location, annotation: self?.toAnnotation)
            }
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
    
    
    
    // MARK: - Networking
    func fetch(location: String, handler: @escaping (Location) -> Void) {
        
        var urlComponents = URLComponents.init(string: "https://nominatim.openstreetmap.org/search")!
        var queryParams = [URLQueryItem]()
        queryParams.append(.init(name: "q", value: location))
        queryParams.append(.init(name: "format", value: "json"))
        
        urlComponents.queryItems = queryParams
        
        guard let url = urlComponents.url else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }) { (locations: [Location]) in
                if let first = locations.first {
                    handler(first)
                }}
        .store(in: &subscriptions)
    }
    
    func fetchHandler(location: Location, annotation: MKPointAnnotation?) {
        if let lat = Double(location.lat), let lon = Double(location.lon) {
            self.setAnnotation(annotation, with: .init(latitude: lat, longitude: lon))
            self.checkDistance()
        }
    }
    
    
    // MARK: - Helper Methods
    func setAnnotation(_ annotation: MKPointAnnotation?, with coordinate: CLLocationCoordinate2D) {
        annotation?.coordinate = coordinate
    }
    
}
