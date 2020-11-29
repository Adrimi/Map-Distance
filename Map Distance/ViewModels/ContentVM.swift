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
    
    var straightDistance: Double = 0
    @Published var navigationDistance: Double = 0
    @Published var navigationRoute: MKPolyline?
    @Published var isShowingDistanceInfo: Bool = false
    
    @Published var mapUpdate: Bool = false
    
    func serachForLocations() {
        fromAnnotation = nil
        toAnnotation = nil
        isShowingDistanceInfo = false
        straightDistance = 0
        navigationDistance = 0
        navigationRoute = nil
        
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
            self.straightDistance = distance
            isShowingDistanceInfo = true
            findNavigationRoute(from: coord1, to: coord2)
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
        
        let url = Endpoint.search(for: location).url
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .tryMap { (data, response) in
                try JSONDecoder().decode([Location].self, from: data)
            }
            .replaceError(with: [])
            .sink { locations in
                    if let firstLocation = locations.first {
                        handler(firstLocation)
                    }
                  }
            .store(in: &subscriptions)
    }
    
    func fetchHandler(location: Location, annotation: MKPointAnnotation?) {
        if let lat = Double(location.lat), let lon = Double(location.lon) {
            self.setAnnotation(annotation, with: .init(latitude: lat, longitude: lon))
            self.checkDistance()
        }
    }
    
    func findNavigationRoute(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) {
        let request: MKDirections.Request = .init()
        request.source = MKMapItem.init(placemark: MKPlacemark.init(coordinate: from))
        request.destination = MKMapItem.init(placemark: MKPlacemark.init(coordinate: to))
        request.transportType = .automobile
        request.requestsAlternateRoutes = false
        
        MKDirections.init(request: request).calculate { [weak self] (response, error) in
            if let route = response?.routes.first {
                self?.navigationDistance = route.distance
                self?.navigationRoute = route.polyline
                self?.updateMap()
            }
        }
    }
    
    
    // MARK: - Helper Methods
    func setAnnotation(_ annotation: MKPointAnnotation?, with coordinate: CLLocationCoordinate2D) {
        annotation?.coordinate = coordinate
    }
    
}

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "nominatim.openstreetmap.org"
        components.path = "/" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
}

extension Endpoint {
    static func search(for query: String, format: String = "json") -> Self {
        Endpoint(
            path: "search",
            queryItems: [
                URLQueryItem(
                    name: "q",
                    value: query),
                URLQueryItem(
                    name: "format",
                    value: format)
            ]
        )
    }
}
