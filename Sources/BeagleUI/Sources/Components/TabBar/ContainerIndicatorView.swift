//
//  ContainerIndicatorView.swift
//  BeagleUI
//
//  Created by Gabriela Coelho on 18/12/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

final class ContainerIndicatorView: UIView {
    lazy var indicatorView: UIView = {
        let view = UIView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = .red
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(indicatorView)
    }
}
