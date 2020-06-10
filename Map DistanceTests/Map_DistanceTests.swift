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

extension Inspection: InspectionEmissary where V: Inspectable {}

extension ContentView: Inspectable {}
extension BasicTextfield: Inspectable {}

class Map_DistanceTests: XCTestCase {

    private var sut: ContentView!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ContentView()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    // Text field test
    func test_textFields_shouldNotHavePlaceholder() throws {
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
    
    func test_textFields_hasProperLabels() throws {
        let label1 = try sut.inspect()
            .vStack()
            .hStack(0)
            .view(BasicTextfield<BasicTextfieldLabel>.self, 0)
            .vStack()
            .textField(0)
            .text()
            .string()
        
        XCTAssertEqual(label1, "FROM")
    }


}
