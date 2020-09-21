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
        tableView.fillSuperview()
        
        tableView.contentInset = .init(top: 20, left: 0, bottom: 0, right: 0)
        
        //MARK: ????? when use small screen device, scrollable cell doesn't use contentInset wihtout this contentOffset
        tableView.contentOffset = CGPoint(x: 0, y: -20)
        
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
        customizingCellAppearance(cell)
        cell.backgroundColor = .clear
        let sectionInfo = infoTypes[indexPath.section]
        cell.textLabel?.text = sectionInfo.attachments[indexPath.row].attachmentTitle
        return cell
    }
    
    private func customizingCellAppearance(_ cell: UITableViewCell) {
        var size: CGFloat = 17
        if traitCollection.horizontalSizeClass == .regular {
            size = 24
        }
        cell.textLabel?.font = .systemFont(ofSize: size)
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
        var size: CGFloat = 20
        if traitCollection.horizontalSizeClass == .regular {
            size = 27
        }
        label.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: size)
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
