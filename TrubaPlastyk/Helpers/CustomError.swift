//
//  CustomError.swift
//  TrubaPlastyk
//
//  Created by Serg on 31.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

enum CustomError {
    case initial
    case showableError(String)
    case wrongFilePath
    case decodingError
    case notConnectedToInternet
    case unknown
}

//extension CustomError: Equatable {
//    static func == (lhs: CustomError, rhs: CustomError) -> Bool {
//        if lhs.self == rhs.self {
//            return true
//        }
//        return false
//    }
//}
