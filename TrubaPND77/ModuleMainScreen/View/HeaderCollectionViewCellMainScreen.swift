//
//  HeaderCollectionViewCell.swift
//  TrubaPND77
//
//  Created by Serg on 02.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

protocol AnimatedViewMainScreenInterface: class {
    var animator: UIViewPropertyAnimator? { get }
}

class HeaderCollectionViewCellMainScreen: UICollectionReusableView, AnimatedViewMainScreenInterface {

    private weak var imageView: UIImageView!
    private weak var stackGradientLayer: CAGradientLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white//#colorLiteral(red: 0.9098039216, green: 0.8901960784, blue: 0.8235294118, alpha: 1)
//        layer.shadowOffset = CGSize(width: 0, height: 10)
//        layer.shadowOpacity = 0.7
//        layer.shadowRadius = 7
        
        
        settingLayout()
        settingGradientLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func settingLayout() {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "headerMainScreen")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        self.imageView = iv
        addSubview(imageView)
        
        //MARK: label for additing telephone number or something else
        
        /*
        let label = UILabel()
        label.text = "+7(495)645-13-06"
        label.font = .boldSystemFont(ofSize: 19)
        label.textColor = .white
        self.blurLabel = label
        addSubview(blurLabel)
        
        blurLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 16))
        */
        
        imageView.fillSuperview()
        setupVisualEffectBlur()
    }
    
    private func settingGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1]
        stackGradientLayer = gradientLayer
        
        let gradientContainerView = UIView()
        self.addSubview(gradientContainerView)
        gradientContainerView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        gradientContainerView.layer.addSublayer(gradientLayer)
        
        gradientLayer.frame = self.bounds
        
        gradientLayer.frame.origin.y -= bounds.height
        
        let headerTitle = UILabel()
        headerTitle.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 25)
        headerTitle.text = "ТРУБА ПНД 77"
        
        headerTitle.numberOfLines = 0
        headerTitle.textColor = .white
        
        let imagePhone = UIImageView(image: UIImage(named: "telephone"))
        imagePhone.contentMode = .scaleAspectFit
        imagePhone.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imagePhone.clipsToBounds = true
        
        let buttonTelephone = UIButton()
        buttonTelephone.setTitle("+7(495)645-13-06", for: .normal)
        buttonTelephone.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        buttonTelephone.contentHorizontalAlignment = .leading
        buttonTelephone.setTitleColor(.white, for: .normal)
        
        //MARK: processing call
        let selector = NSSelectorFromString("phoneNumberWasPressedWithSender:")
        buttonTelephone.addTarget(nil, action: selector, for: .touchUpInside)
        
        let telephoneInfoStackView = UIStackView(arrangedSubviews: [
            imagePhone, buttonTelephone, UIView()
        ])
        
        telephoneInfoStackView.spacing = 8
        telephoneInfoStackView.alignment = .center
        
        let verticalStackView = UIStackView(arrangedSubviews: [
             headerTitle, telephoneInfoStackView
        ])
        
        verticalStackView.axis = .vertical
        
        addSubview(verticalStackView)
        
        verticalStackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16))
        
    }
    
    var animator: UIViewPropertyAnimator?
    
    fileprivate func setupVisualEffectBlur() {
        let visualEffectView = UIVisualEffectView(effect: nil)
        self.addSubview(visualEffectView)
        visualEffectView.fillSuperview()
        
        animator = UIViewPropertyAnimator(duration: 3, curve: .linear) { //MARK: captcher ??? [visualEffectView] in
            visualEffectView.effect = UIBlurEffect(style: .regular)
        }
        
        guard let animator = animator else {
            objectDescription(self, function: #function)
            return
        }
        
        animator.fractionComplete = 0
    }
}
