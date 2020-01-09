//
//  LandingViewController.swift
//  MovieApp
//
//  Created by 汪伦 on 2020/1/9.
//  Copyright © 2020 汪伦. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    let textLabel = UILabel()
    
    var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        let colors = [UIColor("#9FB4E2")!.cgColor, UIColor("#1371FC")!.cgColor]
        gradientLayer.endPoint = CGPoint.init(x: 0.5, y: 0)
        gradientLayer.startPoint = CGPoint.init(x: 0.5, y: 1)
        gradientLayer.colors = colors
        return gradientLayer
    }()

    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        self.view.addSubview(textLabel)
        textLabel.numberOfLines = 2
        textLabel.text = "Welcome\nBack!"
        textLabel.textColor = UIColor.white
        textLabel.font = UIFont.systemFont(ofSize: 60)
        textLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(81)
            maker.left.equalTo(32)
            
        }
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(viewDidTap))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func viewDidTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = self.view.bounds
    }


}
