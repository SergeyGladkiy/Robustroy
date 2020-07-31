//
//  MapperError.swift
//  TrubaPlastyk
//
//  Created by Serg on 31.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

enum NSURLError: Error {
    
    case unknown
    case cancelled
    case badURL
    case timedOut
    case cannotFindHost
    case notConnectedToInternet
    
    var message: String {
        switch self {
        case .badURL:
            return "Bad URL"
        case .cancelled:
            return "Cancelled"
        case .notConnectedToInternet:
            return "not connected to internet"
        case .timedOut:
            return "Timed out"
        case .cannotFindHost:
            return "A server with the specified hostname could not be found"
        case .unknown:
            return "unknow"
        }
    }
}

class MapperError: MapperErrorProtocol {
    
    func parsingError(error: NSError) -> NSURLError {
        switch error.code {
        case -999:
            return .cancelled
        case -1000:
            return .badURL
        case -1001:
            return .timedOut
        case -1003:
            return .cannotFindHost
        case -1009:
            return .notConnectedToInternet
        default:
            return .unknown
        }
    }

}

