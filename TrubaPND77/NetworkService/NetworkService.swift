//
//  NetworkService.swift
//  TrubaPlastyk
//
//  Created by Serg on 31.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

class NetworkService {
    
}

extension NetworkService: NetworkServiceProtocol {
    func request(with url: URL, completion: @escaping (Data?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }.resume()
    }
    
    
}

