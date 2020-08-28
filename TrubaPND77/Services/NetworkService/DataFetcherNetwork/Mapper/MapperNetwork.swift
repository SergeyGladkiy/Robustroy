//
//  MapperError.swift
//  TrubaPlastyk
//
//  Created by Serg on 31.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import SwiftSoup

enum NSURLError: Error {
    
    case unknown
    case cancelled
    case badURL
    case timedOut
    case cannotFindHost
    case parseHtml
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
        case .parseHtml:
            return "parse html was not successful"
        case .unknown:
            return "unknow"
        }
    }
}

class MapperNetwork {
    
}

extension MapperNetwork: MapperNetworkProtocol {
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
    
    func parseHtml(_ data: Data, complition: RepresentItemsCompletion) {
        guard let html = String(data: data, encoding: .utf8) else {
            print("Error encoding " + #function)
            complition(.failure(.parseHtml))
            return
        }
        //MARK: getting all elements "tovar"
        do {
            let doc: Document = try SwiftSoup.parseBodyFragment(html)
            guard
                let allGoods = try? doc.getElementsByClass("tovar"),
                !allGoods.isEmpty
                else {
                    print("Error parseBodyFragment")
                    complition(.failure(.parseHtml))
                    return
            }
            
            var downloadingArray = [RepresentativableItem]()
            //MARK: getting information about each item
            for element in allGoods {
                do {
                    guard
                        let linkHrefPath = try element.select("a[href]").first()?.attr("href"),
                        let imageUrlString = try element.select("img[src]").first()?.attr("src"),
                        let description = try element.getElementsByClass("zag").first()?.text(),
                        let price = try element.getElementsByClass("pri").first()?.ownText()
                        else {
                            print("Error get data from the class <tovar> ")
                            complition(.failure(.parseHtml))
                            return
                    }
//                    print(linkHref)
//                    print(imageUrlString)
//                    print(description)
//                    print(price)
                    
//                    let м.п. = try element.getElementsByClass("pri").first()?.child(0).text()
                    let urlString = API.scheme + API.host + linkHrefPath
                    
                    let item = RepresentativableItem(name: description, price: price, urlImage: imageUrlString, linkToDescription: urlString)
                        
                    downloadingArray.append(item)
                    
                } catch Exception.Error(type: _, Message: let message) {
                    print("Catch parse class <tovar> message: \(message)")
                    complition(.failure(.parseHtml))
                    return
                } catch {
                    print("Catch \(error) parse class <tovar>")
                    complition(.failure(.parseHtml))
                    return
                }
            }
            
            complition(.success(downloadingArray))
            
        } catch Exception.Error(type: _, Message: let message) {
            print("Catch from parseBodyFragment messaga: " + message)
            complition(.failure(.parseHtml))
            return
        } catch {
            print("Catch \(error) from parseBodyFragment")
            complition(.failure(.parseHtml))
            return
        }
    }
    
}

