//
//  NewVC.swift
//  TrubaPND77
//
//  Created by Serg on 21.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class NewVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        navigationItem.title = "greenView"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}
