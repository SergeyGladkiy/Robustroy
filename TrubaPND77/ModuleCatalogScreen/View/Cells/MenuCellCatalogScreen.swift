//
//  MenuCellCatalogScreen.swift
//  TrubaPND77
//
//  Created by Serg on 10.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class MenuCellCatalogScreen: UICollectionViewCell {
    
    private weak var tableView: UITableView!
    private var infoTypes = [TypeItemGroup]()
    var handlerTapOnCell: ((String, String)->())?
    
    var viewModel: CellViewModelCatalogScreen! {
        didSet {
            infoTypes = viewModel.infoTypesGroup
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func settingLayout() {
        let table = UITableView(frame: .zero, style: .grouped)
        if #available(iOS 13.0, *) {
            table.backgroundColor = .secondarySystemBackground

        } else {
            table.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        }
        table.dataSource = self
        table.delegate = self
        self.tableView = table
        addSubview(tableView)
        tableView.fillSuperview(padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
    }
}

extension MenuCellCatalogScreen: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return infoTypes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoTypes[section].attachments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
        //custominzingCellAppearance(cell)
        cell.backgroundColor = .clear
        let sectionInfo = infoTypes[indexPath.section]
        cell.textLabel?.text = sectionInfo.attachments[indexPath.row].attachmentTitle
        return cell
    }
    
    private func custominzingCellAppearance(_ cell: UITableViewCell) {
        if #available(iOS 13.0, *) {
            cell.backgroundColor = .secondarySystemBackground
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        }
    }
}

extension MenuCellCatalogScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let handle = handlerTapOnCell else {
            print("not setting to handlerTapOnCell")
            return
        }
        let sectionInfo = infoTypes[indexPath.section]
        let link = sectionInfo.attachments[indexPath.row].linkHref
        let title = sectionInfo.attachments[indexPath.row].attachmentTitle
        handle(link, title)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = infoTypes[section].titleType
        
        let stackView = UIStackView(arrangedSubviews: [label])
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
}
