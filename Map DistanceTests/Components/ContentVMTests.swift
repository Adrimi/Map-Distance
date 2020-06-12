//
//  ContentVMTests.swift
//  Map DistanceTests
//
//  Created by adrian.szymanowski on 12/06/2020.
//

import XCTest
@testable import Map_Distance

class ContentVMTests: XCTestCase {
    
    // MARK: - ViewModel tests
    func test_viewModel_shouldParseCoordsFromTextField() throws {
        let coordStub = "51.5 21.0"
        let viewModel = ContentVM()
        
        let coords = viewModel.parseStringToCoords(string: coordStub)
        
        XCTAssertEqual(coords!.latitude, 51.5)
        XCTAssertEqual(coords!.longitude, 21.0)
    }
    
}
