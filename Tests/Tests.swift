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
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSetValueTransformers() {
        let names = ValueTransformer.valueTransformerNames()
        var expected = names.count

        StringTransformers.setValueTransformers()
        expected = expected + StringTransformers.transformers.count
        XCTAssertEqual(expected, ValueTransformer.valueTransformerNames().count)

        ImageToRepresentationTransformers.setValueTransformers()
        expected = expected + ImageToRepresentationTransformers.transformers.count * 2
        XCTAssertEqual(expected, ValueTransformer.valueTransformerNames().count)
 
        NSLocale.Key.setValueTransformers()
        expected = expected + NSLocale.Key.transformers.count
        XCTAssertEqual(expected, ValueTransformer.valueTransformerNames().count)
        
        NumberTransformers.setValueTransformers()
        expected = expected + NumberTransformers.transformers.count * 2
        XCTAssertEqual(expected, ValueTransformer.valueTransformerNames().count)
        
        DateTransformers.setValueTransformers()
        expected = expected + DateTransformers.transformers.count * 2
        XCTAssertEqual(expected, ValueTransformer.valueTransformerNames().count)
        
        TimeTransformers.setValueTransformers()
        expected = expected + TimeTransformers.transformers.count * 2
        XCTAssertEqual(expected, ValueTransformer.valueTransformerNames().count)

        for name in ValueTransformer.valueTransformerNames() {
            print(name.rawValue)
            XCTAssertNotNil(ValueTransformer(forName: name))
        }
    }
    
    func testStringTransformers() {
        XCTFail("not implemented")
    }
    
    func testImageToRepresentationTransformers() {
        XCTFail("not implemented")
    }

    func testNumberTransformers() {
        XCTFail("not implemented")
    }

    func testDateTransformers() {
        XCTFail("not implemented")
    }
    
    func testTimeTransformers() {
        XCTFail("not implemented")
    }
}
