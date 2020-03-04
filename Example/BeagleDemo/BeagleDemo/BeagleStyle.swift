//
//  Copyright © 2020 Zup IT. All rights reserved.
//

import UIKit
import BeagleUI

struct Style {
    
    static let theme = AppTheme(styles: [
        "DesignSystem.Button.Style": Style.blackTextNormalStyle,
        "DesignSystem.Text.helloWord": Style.designSystemTextHelloWord,
        "DesignSystem.Text.Image": Style.designSystemTextImage,
        "DesignSystem.Text.Action.Click": Style.designSystemTextActionClick,
        "DesignSystem.Stylish.Button": Style.designSystemStylishButton,
        "DesignSystem.Stylish.ButtonAndAppearance": Style.designSystemStylishButtonAndAppearance,
        "DesignSystem.Form.Submit": Style.formButton,
        "DesignSystem.Navigationbar.Style.Green": Style.designSystemStyleNavigationBar,
        "DesignSystem.Navigationbar.Style.Default": Style.designSystemStyleNavigationBarDefault
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
            $0?.backgroundColor = $0?.isEnabled ?? false ? #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1) : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            $0?.alpha = $0?.isHighlighted ?? false ? 0.7 : 1
        }
    }
}
