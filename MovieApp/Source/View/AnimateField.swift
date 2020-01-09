//
//  AnimateField.swift
//  MovieApp
//
//  Created by 汪伦 on 2020/1/8.
//  Copyright © 2020 汪伦. All rights reserved.
//

import UIKit
import SnapKit

@objc class AnimateField: UIView {
    
    let placeholderLabel = UILabel()
    @objc dynamic let textField = UITextField()
    let bottomLine = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(placeholderLabel)
        placeholderLabel.frame = self.bounds
        placeholderLabel.font = UIFont.systemFont(ofSize: 16)
        placeholderLabel.textColor = UIColor("#7B7B7B")

        addSubview(textField)
        addSubview(bottomLine)

        textField.textColor = UIColor("#E5E5E5")
        textField.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.bottom.equalTo(-3)
            maker.height.equalTo(20)
        }
        
        bottomLine.backgroundColor = UIColor("#707070")
        bottomLine.snp.makeConstraints { (maker) in
            maker.left.right.bottom.equalToSuperview()
            maker.height.equalTo(0.5)
        }
        
        placeholderLabel.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.bottom.equalTo(-3)
            maker.height.equalTo(20)
        }

        textField.addTarget(self, action: #selector(editDidBegin), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)

//        textField.addObserver(self, forKeyPath: "text", options: [NSKeyValueObservingOptions.new, NSKeyValueObservingOptions.old], context: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
    }
    
    @objc func editDidBegin() {
        updatePlaceholderPosition()
    }
    
    @objc func editingDidEnd() {
        updatePlaceholderPosition()
    }
    
    func updatePlaceholderPosition() {
        if self.textField.isEditing || self.textField.text?.count ?? 0 > 0 {
            placeholderLabel.snp.remakeConstraints { (maker) in
                maker.top.left.right.equalToSuperview()
                maker.height.equalTo(20)
            }
        } else {
            placeholderLabel.snp.remakeConstraints { (maker) in
                maker.left.right.equalToSuperview()
                maker.bottom.equalTo(-3)
                maker.height.equalTo(20)
            }
        }
        

        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }

    }

    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if self.textField.isEditing {
//        } else {
//            placeholderLabel.snp.makeConstraints { (maker) in
//                maker.left.right.equalToSuperview()
//                maker.bottom.equalTo(-3)
//                maker.height.equalTo(20)
//            }
//
//            UIView.animate(withDuration: 0.2) {
//                self.layoutIfNeeded()
//            }
//
//        }
//    }

}
