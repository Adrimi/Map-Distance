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
@testable import Map_Distance

extension Inspection: InspectionEmissary where V: Inspectable {}

extension ContentView: Inspectable {}
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

    // MARK: - Tests Methods
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
    
    func test_viewModel_shouldParseCoordsFromTextField() throws {
        let coordsFactory = "51.5 21.0"
        let viewModel = ContentVM()
        
        let coords = viewModel.parseStringToCoords(string: coordsFactory)
        
        XCTAssertEqual(coords.latitude, 51.5)
        XCTAssertEqual(coords.longitude, 21.0)
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

}
