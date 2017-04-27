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
    
    var count: Int {
        return ValueTransformer.valueTransformerNames().count
    }

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testRegister() {
        var expected = count

        StringTransformers.register()
        expected = expected + StringTransformers.transformers.count
        XCTAssertEqual(expected, count)

        ImageRepresentationTransformers.register()
        expected = expected + ImageRepresentationTransformers.transformers.count * 2
        XCTAssertEqual(expected, count)

        NSLocale.Key.register()
        expected = expected + NSLocale.Key.transformers.count
        XCTAssertEqual(expected, count)

        NumberTransformers.register()
        expected = expected + NumberTransformers.transformers.count * 2
        XCTAssertEqual(expected, count)

        DateTransformers.register()
        expected = expected + DateTransformers.transformers.count * 2
        XCTAssertEqual(expected, count)

        TimeTransformers.register()
        expected = expected + TimeTransformers.transformers.count * 2
        XCTAssertEqual(expected, count)

        // Singleton
 
        ArrayToStringTransformer.register()
        expected = expected + 2
        XCTAssertEqual(expected, count)
        
        OrderedSetToArrayValueTransformer.register()
        expected = expected + 2
        XCTAssertEqual(expected, count)

        IdentityTransformer.register()
        expected = expected + 1
        XCTAssertEqual(expected, count)

        IsEmptyTransformer.register()
        expected = expected + 1
        XCTAssertEqual(expected, count)
        
        IsNotEmptyTransformer.register()
        expected = expected + 1
        XCTAssertEqual(expected, count)


        testValueTransformerByName()
    }
    
    func testValueTransformerByName() {
        // Try to get all value transformers using names
        for name in ValueTransformer.valueTransformerNames() {
            print(name.rawValue)
            XCTAssertNotNil(ValueTransformer(forName: name))
        }
    }
    
    func testIdentityTransformer() {
        let tranformer = ValueTransformer.identity

        var transformed = tranformer.transformedValue(nil)
        XCTAssertNil(transformed)
        
        
        var value: String? = nil
        transformed = tranformer.transformedValue(value)
        XCTAssertNil(value)
        XCTAssertEqual(transformed as? String, value)
        
        value = " value"
        transformed = tranformer.transformedValue(value)
        XCTAssertNotNil(value)
        XCTAssertEqual(transformed as? String, value)

        XCTAssertEqual(tranformer.transformedValue(true) as? Bool, true)
        XCTAssertEqual(tranformer.transformedValue(false) as? Bool, false)
    }

    func testStringCapitalizedTransformer() {
        let transformerType = StringTransformers.capitalized
        let transformer = transformerType.transformer
        
        XCTAssertNil(transformerType.transformedValue(nil))
        XCTAssertNil(transformer.transformedValue(nil))
        
        XCTAssertEqual(transformerType.transformedValue("") as? String, "")
        XCTAssertEqual(transformer.transformedValue("") as? String, "")
        
        XCTAssertEqual(transformerType.transformedValue("qwerty") as? String, "Qwerty")
        XCTAssertEqual(transformer.transformedValue("qwerty") as? String, "Qwerty")
        
        XCTAssertEqual(transformerType.transformedValue("qwerTy") as? String, "Qwerty")
        XCTAssertEqual(transformer.transformedValue("qwerTy") as? String, "Qwerty")
        
        XCTAssertEqual(transformerType.transformedValue("QwerTy") as? String, "Qwerty")
        XCTAssertEqual(transformer.transformedValue("QwerTy") as? String, "Qwerty")
    
        XCTAssertEqual(transformerType.transformedValue("Qwer Ty") as? String, "Qwer Ty")
        XCTAssertEqual(transformer.transformedValue("Qwer Ty") as? String, "Qwer Ty")
        
        XCTAssertEqual(transformerType.transformedValue("Qwer ty") as? String, "Qwer Ty")
        XCTAssertEqual(transformer.transformedValue("Qwer ty") as? String, "Qwer Ty")
    }
    
    func testStringUppercasedTransformer() {
        let transformerType = StringTransformers.uppercased
        let transformer = transformerType.transformer

        XCTAssertNil(transformerType.transformedValue(nil))
        XCTAssertNil(transformer.transformedValue(nil))

        XCTAssertEqual(transformerType.transformedValue("") as? String, "")
        XCTAssertEqual(transformer.transformedValue("") as? String, "")

        XCTAssertEqual(transformerType.transformedValue("qwerty") as? String, "QWERTY")
        XCTAssertEqual(transformer.transformedValue("qwerty") as? String, "QWERTY")
        
        XCTAssertEqual(transformerType.transformedValue("qwerTy") as? String, "QWERTY")
        XCTAssertEqual(transformer.transformedValue("qwerTy") as? String, "QWERTY")
        
        XCTAssertEqual(transformerType.transformedValue("QWERTY") as? String, "QWERTY")
        XCTAssertEqual(transformer.transformedValue("QWERTY") as? String, "QWERTY")
    }
    
    func testStringLowercasedTransformer() {
        let transformerType = StringTransformers.lowercased
        let transformer = transformerType.transformer
        
        XCTAssertNil(transformerType.transformedValue(nil))
        XCTAssertNil(transformer.transformedValue(nil))
        
        XCTAssertEqual(transformerType.transformedValue("") as? String, "")
        XCTAssertEqual(transformer.transformedValue("") as? String, "")
        
        XCTAssertEqual(transformerType.transformedValue("qwerty") as? String, "qwerty")
        XCTAssertEqual(transformer.transformedValue("qwerty") as? String, "qwerty")
        
        XCTAssertEqual(transformerType.transformedValue("qwerTy") as? String, "qwerty")
        XCTAssertEqual(transformer.transformedValue("qwerTy") as? String, "qwerty")
        
        XCTAssertEqual(transformerType.transformedValue("QWERTY") as? String, "qwerty")
        XCTAssertEqual(transformer.transformedValue("QWERTY") as? String, "qwerty")
    }
    
    func testClosure() {
        let dico = ["ewrwer": "value", "aeae": nil, true: "test"] as [AnyHashable : String?]
        let valueForNil = "test"
        let transformer = ValueTransformer.closure { object in
            guard let object = object as? AnyHashable else {
                return valueForNil
            }
            return dico[object] ?? nil
        }
        
        for (key, value) in dico {
            let transformed = transformer.transformedValue(key)
            XCTAssertEqual(transformed as? String, value)
        }
        let transformed = transformer.transformedValue(nil)
        XCTAssertEqual(transformed as? String, valueForNil)
    }
    
    func testReverseClosure() {
        let dico = ["ewrwer": "value", "aeae": nil, true: "test"] as [AnyHashable : String?]
        let valueForNil = "test"
        
        
        let transformer = ValueTransformer.closure(forwardTransformer: { object in
            guard let object = object as? AnyHashable else {
                return valueForNil
            }
            return dico[object] ?? nil
        }) { object in
            for (key, value) in dico {
                if value == object as? String {
                    return key
                }
            }
            /*if object == valueForNil {
                return nil
            }*/
            return nil
        }
        
        for (key, value) in dico {
            let transformed = transformer.transformedValue(key)
            XCTAssertEqual(transformed as? String, value)
            
            let reverse = transformer.reverseTransformedValue(transformed)
            XCTAssertEqual(reverse as? AnyHashable, key)
        }
        let transformed = transformer.transformedValue(nil)
        XCTAssertEqual(transformed as? String, valueForNil)
    }

    func _testImageRepresentationTransformers() {
        XCTFail("not implemented")
    }

    func _testNumberTransformers() {
        XCTFail("not implemented")
    }

    func _testDateTransformers() {
        XCTFail("not implemented")
    }

    func _testTimeTransformers() {
        XCTFail("not implemented")
    }
}
