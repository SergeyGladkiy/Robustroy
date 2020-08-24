//
//  NetworkFetcherProtocol.swift
//  TrubaPlastyk
//
//  Created by Serg on 31.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

typealias RepresentItemsCompletion = (Result<[RepresentativableItem], NSURLError>)-> Void

protocol NetworkProtocolAssignmentModule {
    func fetchRepresentItems(completion: @escaping RepresentItemsCompletion)
}
