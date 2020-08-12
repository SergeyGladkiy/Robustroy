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
    //private weak var blurLabel: UILabel!
    private weak var stackGradientLayer: CAGradientLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9098039216, green: 0.8901960784, blue: 0.8235294118, alpha: 1)
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
        iv.image = applySepiaFilter(#imageLiteral(resourceName: "headerMainScreen"))
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
        headerTitle.text = "Производство и продажа трубопроводных систем ПНД"
        
        headerTitle.numberOfLines = 0
        headerTitle.textColor = .white
        
        let imagePhone = UIImageView(image: UIImage(named: "telephone"))
        imagePhone.contentMode = .scaleAspectFit
        imagePhone.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imagePhone.clipsToBounds = true
        
        let labelTelephone = UILabel()
        labelTelephone.text = "+7(495)645-13-06"
        labelTelephone.font = .systemFont(ofSize: 20, weight: .bold)
        labelTelephone.textColor = .white
        labelTelephone.numberOfLines = 0
        
        let telephoneInfoStackView = UIStackView(arrangedSubviews: [
            imagePhone, labelTelephone
        ])
        
        telephoneInfoStackView.spacing = 8
        telephoneInfoStackView.alignment = .center
        
        let verticalStackView = UIStackView(arrangedSubviews: [
             headerTitle, telephoneInfoStackView
        ])
        
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 8
        
        addSubview(verticalStackView)
        
        verticalStackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16))
        
    }
    
    func applySepiaFilter(_ image: UIImage) -> UIImage? {
        guard let data = image.pngData() else {
            objectDescription(self, function: #function)
            return nil
        }
        let inputImage = CIImage(data: data)
        
        let context = CIContext(options: nil)
        
        guard let filter = CIFilter(name: "CISepiaTone") else {
            objectDescription(self, function: #function)
            return nil
        }
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(0.8, forKey: "inputIntensity")
        
        guard
            let outputImage = filter.outputImage,
            let outImage = context.createCGImage(outputImage, from: outputImage.extent)
            else {
                objectDescription(self, function: #function)
                return nil
        }
        
        return UIImage(cgImage: outImage)
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
