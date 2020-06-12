//
//  Map_DistanceTests.swift
//  Map DistanceTests
//
//  Created by adrian.szymanowski on 10/06/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import XCTest
import ViewInspector
import MapKit
import SwiftUI
@testable import Map_Distance

extension Inspection: InspectionEmissary where V: Inspectable {}

extension ContentView: Inspectable {}
extension MapView: Inspectable {}
extension BasicTextField: Inspectable {}
extension BasicTextfieldLabel: Inspectable {}

class Map_DistanceTests: XCTestCase {

    
    // MARK: - Parameters
    private typealias TextField = BasicTextField<BasicTextfieldLabel>
    private typealias InspecedTextField = InspectableView<ViewType.View<Map_DistanceTests.TextField>>
    private var sut: ContentView!
    
    
    // MARK: - Setup
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ContentView()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    // MARK: - Text Fields tests
    func test_contentView_shouldHaveTwoTextFields() throws {
        let textfields = try getTextfields()
        
        XCTAssertEqual(textfields.count, 2)
    }
    
    func test_textFields_shouldHavePlaceholders() throws {
        let placeholdersFactory = [0, 1].map { _ in "Coord/Name" }
        
        let placeholders = try getTextfields().compactMap {
            try $0.vStack()
                .textField(1)
                .text()
                .string()
        }
        
        XCTAssertEqual(placeholders, placeholdersFactory)
    }
    
    func test_textFields_hasProperLabels() throws {
        let labelsFactory = ["FROM", "TO"]
        
        let labels = try getTextfields().compactMap {
            try $0.vStack()
                .view(BasicTextfieldLabel.self, 0)
                .text()
                .string()
        }
        XCTAssertEqual(labels, labelsFactory)
    }
    
    
    // MARK: - ViewModel tests
    func test_viewModel_shouldParseCoordsFromTextField() throws {
        let coordStub = "51.5 21.0"
        let viewModel = ContentVM()
        
        let coords = viewModel.parseStringToCoords(string: coordStub)
        
        XCTAssertEqual(coords!.latitude, 51.5)
        XCTAssertEqual(coords!.longitude, 21.0)
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
        sut.viewModel.fromCoordinate = .fake1
        
        try getMapView { mapView in
            let annotations = try mapView.uiView().annotations
            XCTAssertEqual(annotations.count, 1)
        }
    }
    
    func test_mapView_shouldHaveOneAnnotation_afterSettingToCoordinate() throws {
        sut.viewModel.toCoordinate = .fake2
        
        try getMapView { mapView in
            let annotations = try mapView.uiView().annotations
            XCTAssertEqual(annotations.count, 1)
        }
    }
    
    func test_mapView_shouldHaveTwoAnnotations_afterSettingBoth() throws {
        sut.viewModel.fromCoordinate = .fake1
        sut.viewModel.toCoordinate = .fake2
        
        try getMapView { mapView in
            let annotations = try mapView.uiView().annotations
            XCTAssertEqual(annotations.count, 2)
        }
    }
    
    
    // MARK: - Helper Methods
    private func getTextfields() throws -> [InspecedTextField] {
        let container = try sut.inspect()
            .view(ContentView.self)
            .vStack()
            .hStack(1)
        
        return try [0, 1].compactMap {
            try container.view(TextField.self, $0)
        }
    }
    
    private func getMapView(completion: @escaping (MapView) throws -> Void) throws {
        let exp = sut.inspection.inspect(after: 0.5) { view in
            let mapView = try view
                .vStack()
                .view(MapView.self, 0)
                .actualView()
            
            try completion(mapView)
        }
        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 1.0)
    }
    
}
