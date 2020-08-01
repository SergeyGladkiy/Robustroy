//
//  CustomError.swift
//  TrubaPlastyk
//
//  Created by Serg on 31.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

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

