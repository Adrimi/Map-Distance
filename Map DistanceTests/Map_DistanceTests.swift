//
//  Map_DistanceTests.swift
//  Map DistanceTests
//
//  Created by adrian.szymanowski on 10/06/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import XCTest
import ViewInspector
@testable import Map_Distance

extension ContentView: Inspectable {}


class Map_DistanceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Text field test
    func test_textFields_shouldNotHavePlaceholder() throws {
        let sut = ContentView()
        let value1 = try sut.inspect()
            .vStack()
            .hStack(0)
            .textField(0)
            .text()
            .string()
        
        let value2 = try sut.inspect()
            .vStack()
            .hStack(0)
            .textField(1)
            .text()
            .string()
        
        XCTAssertEqual([value1, value2], ["", ""])
    }


}
