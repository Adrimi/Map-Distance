//
//  ContentVMTests.swift
//  Map DistanceTests
//
//  Created by adrian.szymanowski on 12/06/2020.
//

import XCTest
import MapKit
@testable import Map_Distance

class ContentVMTests: XCTestCase {
    
    var viewModel: ContentVM!
    
    override func setUpWithError() throws {
        viewModel = .init()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func test_shouldParseCoordsFromTextField() {
        let coordStub = "51.5 21.0"
        
        let coords = viewModel.parseStringToCoords(string: coordStub)
        
        XCTAssertEqual(coords!.latitude, 51.5)
        XCTAssertEqual(coords!.longitude, 21.0)
    }
    
    func test_shouldNotHaveInitialAnnotations() {
        XCTAssertNil(viewModel.fromAnnotation)
        XCTAssertNil(viewModel.toAnnotation)
    }
    
    func test_initialDistanceShouldBe0() {
        XCTAssertEqual(viewModel.distance, 0)
    }
    
    func test_afterSettingAnnotations_shouldChangedistance() {
        let fakeAnnotation1 = MKPointAnnotation.fake1
        let fakeAnnotation2 = MKPointAnnotation.fake2
        
        viewModel.fromAnnotation = fakeAnnotation1
        viewModel.toAnnotation = fakeAnnotation2
        
        viewModel.checkDistance()
        
        XCTAssertGreaterThan(viewModel.distance, 0)
    }
    
    func test_updateMap_shouldChangeParamToTrue() {
        viewModel.updateMap()
        
        XCTAssertTrue(viewModel.mapUpdate)
    }
    
    func test_couldChangeAnnotation_viaMethod() {
        let fakeAnnotation1 = MKPointAnnotation.fake1.coordinate
        viewModel.fromAnnotation = .init()
        
        viewModel.setAnnotation(viewModel.fromAnnotation, with: fakeAnnotation1)
        
        XCTAssertEqual(viewModel.fromAnnotation?.coordinate, fakeAnnotation1)
    }
    
    
    // MARK: - Networking
    func test_shouldFetchDataFromService() {
        
    }
    
    
    // MARK: - Helpers
    
    private class ServiceSpy {
        var completion: (([Location]) -> Void)?
        
        func fetch(location: Location, completion: @escaping ([Location]) -> Void) {
            self.completion = completion
        }
    }
    
}
