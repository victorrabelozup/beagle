//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ImageContentModeTests: XCTestCase {
    
    func test_imageContentModeRepresentationToUIKitWhenFitXY_shouldReturnScaleToFill() {
        // Given
        let fitXYContentMode = ImageContentMode.toUIKit(.fitXY)
        let expectedContentMode = UIImageView.ContentMode.scaleToFill
        // When /Then
        XCTAssertEqual(fitXYContentMode(), expectedContentMode, "Expected fitXY to represent ScaleToFill content mode, but got \(String(describing: fitXYContentMode))")
    }
    
    func test_imageContentModeRepresentationToUIKitWhenFitCenter_shouldReturnScaleAspectFit() {
        // Given
        let fitCenterContentMode = ImageContentMode.toUIKit(.fitCenter)
        let expectedContentMode = UIImageView.ContentMode.scaleAspectFit
        // When /Then
        XCTAssertEqual(fitCenterContentMode(), expectedContentMode, "Expected fitCenter to represent ScaleAspectFit content mode, but got \(String(describing: fitCenterContentMode))")
    }
    
    func test_imageContentModeRepresentationToUIKitWhenCenter_shouldReturnCenter() {
        // Given
        let centerContentMode = ImageContentMode.toUIKit(.center)
        let expectedContentMode = UIImageView.ContentMode.center
        // When /Then
        XCTAssertEqual(centerContentMode(), expectedContentMode, "Expected center to represent Center content mode, but got \(String(describing: centerContentMode))")
    }
    
    func test_imageContentModeRepresentationToUIKitWhenFitCenterCrop_shouldReturnScaleAspectFill() {
        // Given
        let centerCropContentMode = ImageContentMode.toUIKit(.centerCrop)
        let expectedContentMode = UIImageView.ContentMode.scaleAspectFill
        // When /Then
        XCTAssertEqual(centerCropContentMode(), expectedContentMode, "Expected fitXY to represent ScaleAspectFill content mode, but got \(String(describing: centerCropContentMode))")
    }
}
