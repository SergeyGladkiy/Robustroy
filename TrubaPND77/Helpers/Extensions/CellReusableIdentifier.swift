//
//  CellReusableIdentifier.swift
//  TrubaPND77
//
//  Created by Serg on 29.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

protocol CellReusabelIdentifier {
    static var reuseIdentifier: String { get }
}

extension UICollectionReusableView: CellReusabelIdentifier {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
