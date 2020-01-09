//
//  LoginViewController.swift
//  MovieApp
//
//  Created by 汪伦 on 2020/1/8.
//  Copyright © 2020 汪伦. All rights reserved.
//

import UIKit
import SnapKit
//import HexColors
import RxSwift
import RxCocoa
import KeyboardMan


class LoginViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let usernameField = AnimateField()
    let passwordField = AnimateField()
    
    let loginButton = UIButton.init(type: .system)
    let backgroundImageView = UIImageView()
    
    let keyboardMan = KeyboardMan()
    let disposeBag = DisposeBag()
    
    var loginButtonGradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        let colors = [UIColor("#9EBCEA")!.cgColor, UIColor("#5D9DFF")!.cgColor]
        gradientLayer.endPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.startPoint = CGPoint.init(x: 1, y: 1)
        gradientLayer.colors = colors
        return gradientLayer
    }()
    
    var gradientBackground = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        setupView()
        bindView()
    }
    
    func setupView() {
        let image = UIImage.init(named: "Component BG")
        backgroundImageView.image = image
        backgroundImageView.contentMode = .scaleAspectFill
        
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(contentView)
        
        contentView.addSubview(usernameField)
        contentView.addSubview(passwordField)
        contentView.addSubview(gradientBackground)
        contentView.addSubview(loginButton)
        passwordField.textField.isSecureTextEntry = true
        
        backgroundImageView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(-74)
            maker.left.equalToSuperview().offset(16)
            maker.right.equalToSuperview().offset(-16)
            maker.height.equalTo(200)
        }
        
        usernameField.snp.makeConstraints { (maker) in
            maker.left.equalTo(0)
            maker.right.equalTo(0)
            maker.top.equalTo(10)
            maker.height.equalTo(44)
        }

        passwordField.snp.makeConstraints { (maker) in
            maker.left.equalTo(0)
            maker.right.equalTo(0)
            maker.top.equalTo(usernameField.snp.bottom).offset(12)
            maker.height.equalTo(44)
        }

        gradientBackground.snp.makeConstraints { (maker) in
            maker.left.equalTo(0)
            maker.right.equalTo(0)
            maker.top.equalTo(passwordField.snp.bottom).offset(20)
            maker.height.equalTo(44)
        }
        
        loginButton.snp.makeConstraints { (maker) in
            maker.left.equalTo(0)
            maker.right.equalTo(0)
            maker.top.equalTo(passwordField.snp.bottom).offset(20)
            maker.height.equalTo(44)
        }
        
        
        usernameField.placeholderLabel.text = "Username"
        passwordField.placeholderLabel.text = "Password"
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        gradientBackground.layer.addSublayer(loginButtonGradientLayer)
        gradientBackground.layer.masksToBounds = true
        
        
        loginButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [unowned self] (Void) in
            let landing = LandingViewController()
            self.present(landing, animated: true, completion: nil)
        }).disposed(by: disposeBag)
            
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(viewDidTap))
            self.view.addGestureRecognizer(tap)
    }
    
    @objc func viewDidTap() {
        self.view.endEditing(true)
    }


    func bindView() {

        keyboardMan.animateWhenKeyboardAppear = { [weak self] appearPostIndex, keyboardHeight, keyboardHeightIncrement in
            self?.contentView.snp.updateConstraints { (maker) in
                maker.bottom.equalTo(-44 - keyboardHeightIncrement)
            }
            
            UIView.animate(withDuration: 0.2) {
                self?.view.layoutIfNeeded()
            }
        }

        keyboardMan.animateWhenKeyboardDisappear = { [weak self] keyboardHeight in

            self?.contentView.snp.updateConstraints { (maker) in
                maker.bottom.equalTo(-74)
            }

            UIView.animate(withDuration: 0.2) {
                self?.view.layoutIfNeeded()
            }
            print("disappear \(keyboardHeight)\n")
        }
    }
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginButtonGradientLayer.frame = loginButton.bounds
        gradientBackground.layer.cornerRadius = loginButton.bounds.height * 0.5
    }

    

}
