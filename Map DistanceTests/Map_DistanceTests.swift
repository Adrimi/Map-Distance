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
extension BasicTextfieldLabel: Inspectable {}

class Map_DistanceTests: XCTestCase {

    
    // MARK: - Parameters
    private typealias TextField = BasicTextfield<BasicTextfieldLabel>
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
    
    func test_textFields_shouldNotHavePlaceholder() throws {
        let textfields = try getTextfields()
        let texts = try textfields.compactMap {
            try $0.vStack()
                .textField(1)
                .text()
                .string()
        }
        
        XCTAssertEqual(texts, ["", ""])
    }
    
    func test_textFields_hasProperLabels() throws {
        let labelsFactory = ["FROM", "TO"]
        
        let textfields = try getTextfields()
        let labels = try textfields.compactMap {
            try $0.vStack()
                .view(BasicTextfieldLabel.self, 0)
                .text()
                .string()
        }
        XCTAssertEqual(labels, labelsFactory)
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
