//
//  Timing.swift
//  TrubaPND77
//
//  Created by Serg on 20.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

public func duration(_ block: () -> ()) -> TimeInterval {
    let startTime = Date()
    block()
    return Date().timeIntervalSince(startTime)
}
