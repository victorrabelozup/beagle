//
//  Copyright © 02/01/20 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class UIViewAppearanceTests: XCTestCase {
    
    func test_invalidHexColor() {
        let color = UIColor(hex: "")
        var r, g, b, a: CGFloat
        (r, g, b, a) = (1, 1, 1, 0)
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        XCTAssertEqual(r, 0)
        XCTAssertEqual(g, 0)
        XCTAssertEqual(b, 0)
        XCTAssertEqual(a, 1)
    }
    
    func test_24BitHex() {
        let color = UIColor(hex: "AABBCC")
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        color.getRed(&r, green: &g, blue: &b, alpha: &a)

        XCTAssertEqual(r, 0xAA / 255)
        XCTAssertEqual(g, 0xBB / 255)
        XCTAssertEqual(b, 0xCC / 255)
        XCTAssertEqual(a, 1)
    }
    
    func test_32BitHex() {
        let color = UIColor(hex: "#75AABBCC")
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        color.getRed(&r, green: &g, blue: &b, alpha: &a)

        XCTAssertEqual(r, 0xAA / 255)
        XCTAssertEqual(g, 0xBB / 255)
        XCTAssertEqual(b, 0xCC / 255)
        XCTAssertEqual(a, 0x75 / 255)
    }
}
