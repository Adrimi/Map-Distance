//
//  MapViewTests.swift
//  Map DistanceTests
//
//  Created by adrian.szymanowski on 12/06/2020.
//

import XCTest
import ViewInspector
import MapKit
@testable import Map_Distance


class MapViewTests: XCTestCase {

    // MARK: - Parameters
    private var sut: ContentView!
    
    
    // MARK: - Setup
    override func setUpWithError() throws {
        sut = ContentView()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    
    // MARK: - Map View tests
    func test_mapView_shouldHaveNoAnnotationsAtStart() throws {
        try getMapView { mapView in
            let annotations = try mapView
                .uiView()
                .annotations
            XCTAssertTrue(annotations.isEmpty)
        }
    }
    
    func test_mapView_shouldHaveOneAnnotation_afterSettingFromCoordinate() throws {
        sut.viewModel.fromAnnotation = .fake1
        
        try getMapView { mapView in
            let annotations = try mapView.uiView().annotations
            XCTAssertEqual(annotations.count, 1)
        }
    }
    
    func test_mapView_shouldHaveOneAnnotation_afterSettingToCoordinate() throws {
        sut.viewModel.toAnnotation = .fake2
        
        try getMapView { mapView in
            let annotations = try mapView.uiView().annotations
            XCTAssertEqual(annotations.count, 1)
        }
    }
    
    func test_mapView_shouldHaveTwoAnnotations_afterSettingBoth() throws {
        sut.viewModel.fromAnnotation = .fake1
        sut.viewModel.toAnnotation = .fake2
        
        try getMapView { mapView in
            let annotations = try mapView.uiView().annotations
            XCTAssertEqual(annotations.count, 2)
        }
    }
    
    
    // MARK: - Helper Methods
    private func getMapView(completion: @escaping (MapView) throws -> Void) throws {
        let exp = sut.inspection.inspect(after: 0.5) { view in
            let mapView = try view
                .vStack()
                .zStack(0)
                .view(MapView.self, 0)
                .actualView()
            
            try completion(mapView)
        }
        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 1.0)
    }
}
