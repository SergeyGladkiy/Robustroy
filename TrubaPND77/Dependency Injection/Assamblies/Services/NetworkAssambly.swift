//
//  NetworkAssambly.swift
//  TrubaPND77
//
//  Created by Serg on 22.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import Swinject

class NetworkAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkProtocolAssignmentModule.self) { r in
            let networking = r.resolve(NetworkingProtocol.self)!
            let mapper = r.resolve(MapperNetworkProtocol.self)!
            return NetworkDataFetcher(networking: networking, mapper: mapper)
        }
        
        container.register(NetworkingProtocol.self) { _ in
            Networking()
        }
        
        container.register(MapperNetworkProtocol.self) { _ in
            MapperNetwork()
        }
    }
}
