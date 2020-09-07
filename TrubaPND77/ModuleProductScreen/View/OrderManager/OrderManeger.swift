//
//  OrderManeger.swift
//  TrubaPND77
//
//  Created by Serg on 05.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class OrderManeger {
    private weak var darkCoverView: UIView!
    private var isOrderMenuOpened = false
    
    private func processingDarkCoverView() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: { [weak self] in
            guard let self = self else {
                print("MainViewController is deinit")
                return
            }
            
            self.darkCoverView.alpha = self.isOrderMenuOpened ? 0.9 : 0
        })
    }
    
    @objc func handleTapDismiss() {
        isOrderMenuOpened = false
        processingDarkCoverView()
    }
}

extension OrderManeger: OrderingProtocol {
    func settingCustomLayout(with refView: UIView) {
        let coverView = UIView()
        coverView.backgroundColor = .init(white: 0, alpha: 0.7)
        coverView.alpha = 0
        self.darkCoverView = coverView
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss))
        darkCoverView.addGestureRecognizer(tapGesture)
        
        darkCoverView.translatesAutoresizingMaskIntoConstraints = false
        //refView.addSubview(darkCoverView)
        let window = UIApplication.shared.windows.first
        window?.addSubview(darkCoverView)
        
        NSLayoutConstraint.activate([
            darkCoverView.topAnchor.constraint(equalTo: window!.topAnchor),
            darkCoverView.leadingAnchor.constraint(equalTo: window!.leadingAnchor),
            darkCoverView.bottomAnchor.constraint(equalTo: window!.bottomAnchor),
            darkCoverView.trailingAnchor.constraint(equalTo: window!.trailingAnchor)
        ])
    }
    
    func openOrderInfoList() {
        isOrderMenuOpened = true
        processingDarkCoverView()
    }
    
}
