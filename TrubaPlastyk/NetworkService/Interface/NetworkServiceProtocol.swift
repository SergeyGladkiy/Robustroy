//
//  NetworkServiceProtocol.swift
//  TrubaPlastyk
//
//  Created by Serg on 31.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func request(with url: URL, completion: @escaping (Data?, Error?) -> Void)
}
