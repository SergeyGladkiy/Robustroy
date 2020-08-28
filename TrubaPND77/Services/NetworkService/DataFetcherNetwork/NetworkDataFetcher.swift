//
//  NetworkFetcher.swift
//  TrubaPlastyk
//
//  Created by Serg on 31.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

class NetworkDataFetcher {
    private let networkServece: NetworkingProtocol
    private let mapper: MapperNetworkProtocol
    
    init(networking: NetworkingProtocol, mapper: MapperNetworkProtocol) {
        networkServece = networking
        self.mapper = mapper
    }
    
}

extension NetworkDataFetcher: NetworkProtocolAssignmentModule {
    func fetchRepresentItems(completion: @escaping RepresentItemsCompletion) {
        let stringUrl = API.scheme + API.host + API.path
        
        guard let url = URL(string: stringUrl) else {
            completion(.failure(.badURL))
            return
        }
        
        networkServece.request(with: url) { [weak self] (data, error) in
            guard let self = self else {
                print("self (network data fetcher) is nil")
                return
            }
            
            if let error = error {
                let customError = self.mapper.parsingError(error: error as NSError)
                completion(.failure(customError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.unknown))
                return
            }
            
            self.mapper.parseHtml(data, complition: completion)
            
        }
    }
    
}
