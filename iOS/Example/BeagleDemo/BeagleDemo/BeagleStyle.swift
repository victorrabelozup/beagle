//
//  Copyright © 2020 Zup IT. All rights reserved.
//

import UIKit
import BeagleUI

struct Style {
    
    static let theme = AppTheme(styles: [
        .BUTTON_BLACK_TEXT_STYLE: Style.blackTextNormalStyle,
        .TEXT_HELLO_WORD_STYLE: Style.designSystemTextHelloWord,
        .TEXT_IMAGE_STYLE: Style.designSystemTextImage,
        .TEXT_ACTION_CLICK_STYLE: Style.designSystemTextActionClick,
        .TEXT_STYLISH_STYLE: Style.designSystemStylishButton,
        .BUTTON_WITH_APPEARANCE_STYLE: Style.designSystemStylishButtonAndAppearance,
        .FORM_SUBMIT_STYLE: Style.formButton,
        .NAVIGATION_BAR_GREEN_STYLE: Style.designSystemStyleNavigationBar,
        .NAVIGATION_BAR_DEFAULT_STYLE: Style.designSystemStyleNavigationBarDefault,
        .TAB_VIEW_STYLE: Style.tabView
        ]
    )
    
    static func blackTextNormalStyle() -> (UILabel?) -> Void {
        return BeagleStyle.label(withTextColor: .black)
    }
    
    static func designSystemTextHelloWord() -> (UILabel?) -> Void {
        return BeagleStyle.label(font: .boldSystemFont(ofSize: 18), color: .darkGray)
    }
    
    static func designSystemTextImage() -> (UILabel?) -> Void {
        return BeagleStyle.label(font: .boldSystemFont(ofSize: 12), color: .black)
    }
    
    static func designSystemTextActionClick() -> (UILabel?) -> Void {
        return BeagleStyle.label(font: .boldSystemFont(ofSize: 40), color: .black)
    }
    
    static func designSystemStylishButton() -> (UIButton?) -> Void {
        return BeagleStyle.button(withTitleColor: .black)
            <> {
                $0?.titleLabel |> BeagleStyle.label(withFont: .systemFont(ofSize: 16, weight: .semibold))
        }
    }
    
    static func designSystemStylishButtonAndAppearance() -> (UIButton?) -> Void {
        return BeagleStyle.button(withTitleColor: .white)
            <> {
                $0?.titleLabel |> BeagleStyle.label(withFont: .systemFont(ofSize: 16, weight: .semibold))
        }
    }
    
    
    static func designSystemStyleNavigationBar() -> (UINavigationBar?) -> Void {
        return {
            $0?.barTintColor = .green
            $0?.isTranslucent = false
        }
    }
    
    static func designSystemStyleNavigationBarDefault() -> (UINavigationBar?) -> Void {
        return {
            $0?.barTintColor = nil
            $0?.isTranslucent = true
        }
    }

    static func formButton() -> (UIButton?) -> Void {
        return {
            $0?.layer.cornerRadius = 4
            $0?.setTitleColor(.white, for: .normal)
            $0?.backgroundColor = $0?.isEnabled ?? false ? UIColor(hex: .GREEN_COLOR) : UIColor(hex: .GRAY_COLOR)
            $0?.alpha = $0?.isHighlighted ?? false ? 0.7 : 1
        }
    }
    
    static func tabView() -> (UIView?) -> Void {
        
        return BeagleStyle.tabView(backgroundColor: .clear, indicatorColor: UIColor(hex: .ORANGE_COLOR), selectedTextColor: UIColor(hex: .ORANGE_COLOR), unselectedTextColor: UIColor(hex: .DARK_GRAY_COLOR))
    }
}
