//
//  Tests.swift
//  Tests
//
//  Created by phimage on 06/04/2017.
//  Copyright © 2017 phimage (Eric Marchand). All rights reserved.
//

import XCTest
import ValueTransformerKit

class Tests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSetValueTransformers() {
        let names = ValueTransformer.valueTransformerNames()
        var expected = names.count

        StringTransformers.setValueTransformers()
        expected = expected + StringTransformers.transformers.count
        XCTAssertEqual(expected, ValueTransformer.valueTransformerNames().count)

        ImageToRepresentationTransformers.setValueTransformers()
        expected = expected + ImageToRepresentationTransformers.transformers.count
        XCTAssertEqual(expected, ValueTransformer.valueTransformerNames().count)

        RepresentationToImageTransformers.setValueTransformers()
        expected = expected + RepresentationToImageTransformers.transformers.count
        XCTAssertEqual(expected, ValueTransformer.valueTransformerNames().count)

        NSLocale.Key.setValueTransformers()
        expected = expected + NSLocale.Key.transformers.count
        XCTAssertEqual(expected, ValueTransformer.valueTransformerNames().count)
        
        for name in ValueTransformer.valueTransformerNames() {
            print(name.rawValue)
            XCTAssertNotNil(ValueTransformer(forName: name))
        }
    }

}
