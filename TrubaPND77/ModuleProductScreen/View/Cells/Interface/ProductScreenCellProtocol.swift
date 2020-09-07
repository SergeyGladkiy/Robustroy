//
//  ProductScreenCellProtocol.swift
//  TrubaPND77
//
//  Created by Serg on 04.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

protocol ProductScreenCellProtocol: UITableViewCell {
    var viewModel: CellViewModelProductScreen? { get set }
}
