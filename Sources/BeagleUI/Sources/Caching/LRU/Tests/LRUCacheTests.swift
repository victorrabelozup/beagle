//
//  Copyright © 10/02/20 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

class LRUCacheTests: XCTestCase {
    
    lazy var sut = CacheLRU<String, String>(capacity: 2)
    let key1 = "key1"
    let key2 = "key2"
    let key3 = "key3"
    let val1 = "val1"
    let val2 = "val2"
    let val3 = "val3"
    
    func testLRUInsert() {
        sut.setValue(val1, for: key1)
        
        XCTAssert(sut.count == 1)
        XCTAssert(sut.getValue(for: key1) == val1)
    }
    
    func testLRUClear() {
        sut.setValue(val1, for: key1)
        sut.setValue(val2, for: key2)
        
        sut.clear()
        
        XCTAssert(sut.count == 0)
        XCTAssert(sut.getValue(for: key1) == nil)
        XCTAssert(sut.getValue(for: key2) == nil)
    }
    
    func testLRUDump() {
        sut.setValue(val1, for: key1)
        sut.setValue(val2, for: key2)
        sut.setValue(val3, for: key3)
        
        XCTAssert(sut.count ==  2)
        XCTAssert(sut.getValue(for: key1) == nil)
        XCTAssert(sut.getValue(for: key2) == val2)
        XCTAssert(sut.getValue(for: key3) == val3)
    }
    
    func testUpdateValue() {
        let val11 = "val1.1"
        sut.setValue(val1, for: key1)
        sut.setValue(val2, for: key2)
        
        sut.setValue(val11, for: key1)
        
        XCTAssert(sut.count ==  2)
        XCTAssert(sut.getValue(for: key1) == val11)
        XCTAssert(sut.getValue(for: key2) == val2)
    }
    
    func testRefreshElementUsage() {
        let val11 = "val1.1"
        sut.setValue(val1, for: key1)
        sut.setValue(val2, for: key2)
        
        sut.setValue(val11, for: key1)
        sut.setValue(val3, for: key3)
        
        XCTAssert(sut.count ==  2)
        XCTAssert(sut.getValue(for: key1) == val11)
        XCTAssert(sut.getValue(for: key2) == nil)
        XCTAssert(sut.getValue(for: key3) == val3)
    }
}
