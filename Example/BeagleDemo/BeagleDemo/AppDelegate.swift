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
        
        let theme = AppTheme(styles: ["h1": BeagleStyle.h1Style, "grayButton": BeagleStyle.grayButton])
        Beagle.start(appName: "BeagleDemo", deepLinkHandler: DeepLinkHandler(), applicationTheme: theme)
        let rootViewController = UINavigationController(rootViewController: BeagleScreenViewController(screenType: .declarative(TextScreen())))
        
        window = UIWindow()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }

}

struct TextScreen: Screen {
    var content: Widget {
        ListView {
            Navigator(action: Navigate(type: .openDeepLink, path: "ViewController1", data: ["title":"screen 1"])) {
                 Button(text: "OPEN NATIVE SCREEN 1", style: "grayButton")
            }
            Navigator(action: Navigate(type: .openDeepLink, path: "ViewController2", data: ["title":"screen 2"])) {
                 Button(text: "OPEN NATIVE SCREEN 2", style: "grayButton")
            }
        }
    }
}

class DeepLinkHandler: BeagleDeepLinkScreenManaging {
    func getNaviteScreen(with path: String, data: [String : String]?) throws -> UIViewController {
        if path == "ViewController1" {
            return ViewController1()
        } else {
            return ViewController2()
        }
    }
}

class ViewController1: UIViewController {
    
    override func viewDidLoad() {
        let view = UIButton(frame: self.view.frame)
        view.setTitle("POP", for: .normal)
        view.addTarget(self, action: #selector(popView), for: .touchDown)
        view.backgroundColor = .red
        self.view.addSubview(view)
    }
    
    @objc func popView() {
        self.navigationController?.popViewController(animated: true)
    }
}

class ViewController2: UIViewController {
    
    override func viewDidLoad() {
        let view = UIButton(frame: self.view.frame)
        view.setTitle("POP", for: .normal)
        view.addTarget(self, action: #selector(popView), for: .touchDown)
        view.backgroundColor = .green
        self.view.addSubview(view)
    }
    
    @objc func popView() {
        self.navigationController?.popViewController(animated: true)
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
}
