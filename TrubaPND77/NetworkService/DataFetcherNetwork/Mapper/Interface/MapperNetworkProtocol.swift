//
//  MapperErrorProtocol.swift
//  TrubaPlastyk
//
//  Created by Serg on 31.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol MapperNetworkProtocol {
    func parsingError(error: NSError) -> NSURLError
    func parseHtml(_ data: Data, complition: RepresentItemsCompletion)
}
