//
//  AppDelegate.swift
//  BeagleDemo
//
//  Created by Daniel Tes on 10/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//
import UIKit
import BeagleUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let theme = AppTheme(styles: [
            "h1": BeagleStyle.h1Style,
            "grayButton": BeagleStyle.grayButton,
            "background": BeagleStyle.viewWithBackgroundColor
        ])
        Beagle.start(appName: "BeagleDemo", applicationTheme: theme)

        Beagle.registerCustomWidget(.init(entity: .init(typeName: "Bla", type: CustomPageIndicatorEntity.self), view: .init(widgetType: CustomPageIndicator.self, viewRenderer: CustomPageIndicatorRenderer.self)))

        let root = BeagleScreenViewController(screenType: .declarative(PageView(
            pages: Array(repeating: Page(), count: 3).map { $0.content }, pageIndicator: CustomPageIndicator(selectedColor: "", defaultColor: "")
        )))

        window = UIWindow()
        window?.rootViewController = root
        window?.makeKeyAndVisible()

        return true
    }

}


struct Page {
    var content: FlexWidget {
        FlexWidget {
            Text("Blaaslkdjfaskldjfalskdjfasldjfasldfj")
            NetworkImage(url: "https://is5-ssl.mzstatic.com/image/thumb/Purple123/v4/47/b9/9b/47b99ba2-8b0e-9b08-96f6-70cc8a22d773/source/256x256bb.jpg")
            Text("Blaaslkdjfaskldjfalskdjfasldjfasldfj")
        }
    }
}

extension BeagleStyle {
    static func h1Style() -> (UILabel?) -> Void {
        label(font: .systemFont(ofSize: 10), color: .black)
    }

    static func h2Style() -> (UILabel?) -> Void {
        label(font: .systemFont(ofSize: 14), color: .black)
    }

    static func h3Style() -> (UILabel?) -> Void {
        label(font: .systemFont(ofSize: 16), color: .black)
    }

    static func grayButton() -> (UIButton?) -> Void {
        backgroundColor(withColor: .gray)
            <> {
                $0?.titleLabel |> h1Style()
        }
    }

    static func viewWithBackgroundColor() -> (UIView?) -> Void {
        return { view in
            view?.backgroundColor = .gray
        }
    }
}
