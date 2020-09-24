//
/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import UIKit
import Beagle
import BeagleSchema

class BeagleViewViewController: UIViewController, DeeplinkScreen {

    // MARK: Init
    required init(path: String, data: [String: String]?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setupView()
    }
    
    func screenController() -> UIViewController {
         return BeagleViewViewController(path: "", data: nil)
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Beagle"
    }
    
    private lazy var beagleViewCenter = BeagleView(.remote(.init(url: "/centerBeagleView")))
    
    private lazy var beagleViewBottom = BeagleView(.remote(.init(url: "/bottomBeagleView")))
    
    private lazy var titleScreen = makeLabel(
        text: "I'm a native screen",
        sizeText: 25,
        weight: .bold
    )
    
    private lazy var descriptionScreen = makeLabel(
        text: "BeagleView is a view to use in the middle of the automatic layout that manages to bring declarative and remote components through BFF.",
        sizeText: 20,
        weight: .regular
    )
    
    private lazy var attentionScreen = makeLabel(
        text: "The two cards built are beagleView and their components are sent from BFF.",
        sizeText: 20,
        weight: .black,
        colorText: "#ff414d"
    )
    
    private lazy var documentationTitle = makeLabel(
        text: "Documentation",
        sizeText: 25,
        weight: .bold
    )
    
    private lazy var documentationDetail = makeLabel(
        text: "To learn more, access the documentation and see implementation details.",
        sizeText: 20,
        weight: .regular
    )
    
    private lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
       return scrollView
    }()
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor
        )
        
        scrollView.addSubview(titleScreen)
        titleScreen.anchorCenterXToSuperview()
        titleScreen.anchor(
            top: scrollView.topAnchor,
            topConstant: 30
        )
        
        scrollView.addSubview(descriptionScreen)
        descriptionScreen.anchor(
            top: titleScreen.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 15,
            leftConstant: 20,
            rightConstant: 20
        )
        
        scrollView.addSubview(attentionScreen)
        attentionScreen.anchor(
            top: descriptionScreen.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 15,
            leftConstant: 20,
            rightConstant: 20
        )
        
        scrollView.addSubview(beagleViewCenter)
        beagleViewCenter.anchor(
            top: attentionScreen.bottomAnchor,
            left: scrollView.leftAnchor,
            right: scrollView.rightAnchor,
            topConstant: 30
        )
        
        scrollView.addSubview(documentationTitle)
        documentationTitle.anchorCenterXToSuperview()
        documentationTitle.anchor(
            top: beagleViewCenter.bottomAnchor,
            topConstant: 30
        )
        
        scrollView.addSubview(documentationDetail)
        documentationDetail.anchor(
            top: documentationTitle.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 15,
            leftConstant: 20,
            rightConstant: 20
        )
        
        scrollView.addSubview(beagleViewBottom)
        beagleViewBottom.anchor(
            top: documentationDetail.bottomAnchor,
            left: scrollView.leftAnchor,
            bottom: scrollView.bottomAnchor,
            right: scrollView.rightAnchor,
            topConstant: 30,
            bottomConstant: 20
        )
        
    }
    
    private func makeLabel(
        text: String,
        sizeText: CGFloat,
        weight: UIFont.Weight,
        colorText: String? = nil
    ) -> UILabel {
           let label = UILabel()
           label.text = text
           label.numberOfLines = 0
           label.textAlignment = .center
           label.font = .systemFont(ofSize: sizeText, weight: weight)
        label.textColor = UIColor(hex: colorText ?? .black)
           return label
       }
}
