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
    
    private weak var nameTitle: UILabel!
    private weak var telephone: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingLayout()
        setupVisualEffectBlur()
        settingGradientLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func settingLayout() {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "headerImage")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        self.imageView = iv
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    override func updateConstraints() {
        if traitCollection.horizontalSizeClass == .regular {
            nameTitle.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 45)
            telephone.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        }
        super.updateConstraints()
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
        headerTitle.text = "Robustрой"
        headerTitle.numberOfLines = 0
        headerTitle.textColor = .white
        self.nameTitle = headerTitle
        
        let imagePhone = UIImageView(image: UIImage(named: "telephone"))
        imagePhone.contentMode = .scaleAspectFit
        imagePhone.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        let buttonTelephone = UIButton()
        buttonTelephone.setTitle("+7(495)645-13-06", for: .normal)
        buttonTelephone.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        buttonTelephone.contentHorizontalAlignment = .leading
        buttonTelephone.setTitleColor(.white, for: .normal)
        self.telephone = buttonTelephone
        
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
        
        //MARK: for rid the warning height ambigues
        //gradientContainerView.heightAnchor.constraint(equalToConstant: verticalStackView.frame.height).isActive = true
    }
    
    var animator: UIViewPropertyAnimator?
    
    fileprivate func setupVisualEffectBlur() {
        let visualEffectView = UIVisualEffectView(effect: nil)
        self.addSubview(visualEffectView)
        visualEffectView.fillSuperview()
        
        animator = UIViewPropertyAnimator(duration: 3, curve: .linear) { //MARK: captcher ??? [visualEffectView] in
            visualEffectView.effect = UIBlurEffect(style: .regular)
        }
        animator?.pausesOnCompletion = true
        animator?.fractionComplete = 0
    }
    
    func applySepiaFilter(_ image: UIImage) -> UIImage? {
        guard let data = image.pngData() else { return nil }
      let inputImage = CIImage(data: data)
      
      let context = CIContext(options: nil)
      
      guard let filter = CIFilter(name: "CIColorPosterize") else { return nil }
      filter.setValue(inputImage, forKey: kCIInputImageKey)
      //filter.setValue(0.8, forKey: "inputIntensity")
        filter.setValue(2.7, forKey: "inputLevels")
      
      guard
        let outputImage = filter.outputImage,
        let outImage = context.createCGImage(outputImage, from: outputImage.extent)
      else {
        return nil
      }
      
      return UIImage(cgImage: outImage)
    }
}

