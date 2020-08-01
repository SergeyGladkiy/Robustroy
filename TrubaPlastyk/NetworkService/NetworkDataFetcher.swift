//
//  NetworkFetcher.swift
//  TrubaPlastyk
//
//  Created by Serg on 31.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

class NetworkDataFetcher {
    private let networkServece: NetworkServiceProtocol
    private let mapper: MapperNetworkErrorProtocol
    
    init(networking: NetworkServiceProtocol, mapper: MapperNetworkErrorProtocol) {
        networkServece = networking
        self.mapper = mapper
    }
}

extension NetworkDataFetcher: NetworkingMainScreen {
    func fetchInformationAboutServer(completion: @escaping ServerConnectionCheckCompletion) {
        
        let path = "http://www.trubaplastyk.ru"
        guard let url = URL(string: path) else {
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
            print(data)
            completion(.success(data))
            
        }
    }
    
}
