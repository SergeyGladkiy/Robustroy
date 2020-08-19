//
//  NetworkFetcherProtocol.swift
//  TrubaPlastyk
//
//  Created by Serg on 31.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

typealias ServerConnectionCheckCompletion = (Result<Data, NSURLError>)-> Void

protocol NetworkingMainScreen {
    func fetchInformationAboutServer(completion: @escaping ServerConnectionCheckCompletion)
}
