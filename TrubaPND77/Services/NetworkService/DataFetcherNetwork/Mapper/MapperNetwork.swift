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
    
    func parseHtmlForRepresentItems(_ data: Data, completion: RepresentItemsCompletion) {
        guard let html = String(data: data, encoding: .utf8) else {
            print("Error encoding " + #function)
            completion(.failure(.parseHtml))
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
                    completion(.failure(.parseHtml))
                    return
            }
            
            var downloadingArray = [RepresentativableItem]()
            //MARK: getting information about each item
            for element in allGoods {
                do {
                    guard
                        let linkHrefPath = try element.select("a[href]").first()?.attr("href"),
                        let imageUrlString = try element.select("img[src]").first()?.attr("src"),
                        let titleProduct = try element.select("img[src]").first()?.attr("alt"),
                        let nameProduct = try element.getElementsByClass("zag").first()?.text(),
                        let price = try element.getElementsByClass("pri").first()?.ownText()
                        else {
                            print("Error get data from the class <tovar> ")
                            completion(.failure(.parseHtml))
                            return
                    }
                    
                    //print("title product = \(titleProduct)")
//                    print(linkHref)
//                    print(imageUrlString)
//                    print(description)
//                    print(price)
                    
//                    let м.п. = try element.getElementsByClass("pri").first()?.child(0).text()
                    let urlString = linkHrefPath
                    
                    let item = RepresentativableItem(name: nameProduct, title: titleProduct, price: price, urlImage: imageUrlString, linkToDescription: urlString)
                        
                    downloadingArray.append(item)
                    
                } catch Exception.Error(type: _, Message: let message) {
                    print("Catch parse class <tovar> message: \(message)")
                    completion(.failure(.parseHtml))
                    return
                } catch {
                    print("Catch \(error) parse class <tovar>")
                    completion(.failure(.parseHtml))
                    return
                }
            }
            
            completion(.success(downloadingArray))
            
        } catch Exception.Error(type: _, Message: let message) {
            print("Catch from parseBodyFragment messaga: " + message)
            completion(.failure(.parseHtml))
            return
        } catch {
            print("Catch \(error) from parseBodyFragment")
            completion(.failure(.parseHtml))
            return
        }
    }
    
    func parseHtmlForItemInformation(_ data: Data, completion: (Result<ItemInformation, NSURLError>) -> Void) {
        
        guard let html = String(data: data, encoding: .utf8) else {
            print("Error encoding " + #function)
            completion(.failure(.parseHtml))
            return
        }
        
        do {
            
            let doc: Document = try SwiftSoup.parseBodyFragment(html)
            
            guard
                let catalog = try? doc.getElementsByClass("catalog").first(),
                let haract = try? catalog.getElementsByClass("harakt").first()?.text(),
                let oTovare = try? catalog.getElementsByClass("abou").first()?.text()//,
                //let urlImage = try? catalog.getElementsByClass("big_img").first()?.select("img[src]").first()?.attr("src")
                else {
                    print("Error parseBodyFragment")
                    completion(.failure(.parseHtml))
                    return
            }
            
            var dictionaryCharact = [String: String]()
            var arrayParagraphs = [String]()
            var arrayLists = [String]()
            
            if haract != "Краткие характеристики:" {
                guard let allHaract = try? catalog.getElementsByClass("pnk") else {
                    print("Error get all info of charateristics")
                    completion(.failure(.parseHtml))
                    return
                }
                
                for element in allHaract {
                    guard
                        let key = try? element.child(0).text(),
                        let value = try? element.child(1).text()
                        else {
                            print("Error get text of character")
                            completion(.failure(.parseHtml))
                            return
                    }
                    dictionaryCharact[key] = value
                }
            }
            
            if oTovare != "О ТОВАРЕ" {
                guard let allTextParagraphs = try? catalog.getElementsByClass("abou").first()?.select("p"), let allTextLists = try? catalog.getElementsByClass("abou").first()?.select("li")
                    else {
                        print("Error get all info about the product")
                        completion(.failure(.parseHtml))
                        return
                }
                
                for element in allTextParagraphs {
                    guard let text = try? element.text() else {
                        print("Error get text of paragraphs")
                        completion(.failure(.parseHtml))
                        return
                    }
                    if !text.isEmpty {
                        arrayParagraphs.append(text)
                    }
                }
                
                for element in allTextLists {
                    guard let text = try? element.text() else {
                        print("Error get text of lists")
                        completion(.failure(.parseHtml))
                        return
                    }
                    arrayLists.append(text)
                }
            }
            
            let informationItem = ItemInformation(characteristiks: dictionaryCharact, infoAboutItem: InfoAboutItem(paragraphs: arrayParagraphs, lists: arrayLists))
            
            completion(.success(informationItem))
            
        } catch Exception.Error(type: _, Message: let message) {
            print("Catch from parseBodyFragment messaga: " + message)
            completion(.failure(.parseHtml))
            return
        } catch {
            print("Catch \(error) from parseBodyFragment")
            completion(.failure(.parseHtml))
        }
    }
}
