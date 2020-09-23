//
//  AboutCompanyScreenController.swift
//  TrubaPND77
//
//  Created by Serg on 15.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class AboutCompanyScreenController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        settingTableView()
    }
    
    private func settingTableView() {
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    //MARK: UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AboutCompanyCellDescription()
        return cell
    }
}
