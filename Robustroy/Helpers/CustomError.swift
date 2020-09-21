//
//  CustomError.swift
//  TrubaPlastyk
//
//  Created by Serg on 31.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

func objectDescription(_ subject: AnyObject, function: String) {
    print("ERROR " + String(describing: subject) + " " + function)
}

var unknownError: String {
    return "Неизвестная ошибка 😫"
}


enum CustomError {
    case initial
    case showableError(String)
    case wrongFilePath
    case decodingError
    case notConnectedToInternet
    case unknown
}

//MARK: study equatable protocol for connecting params of enum
//extension CustomError: Equatable {
//    static func == (lhs: CustomError, rhs: CustomError) -> Bool {
//        let error = "error"
//        if lhs == .showableError(error)  {
//            return true
//        }
//        return false
//    }
//}
