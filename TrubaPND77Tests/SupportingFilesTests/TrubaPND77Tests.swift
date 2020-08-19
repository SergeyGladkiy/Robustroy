//
//  SceneDelegateTests.swift
//  TrubaPND77Tests
//
//  Created by Serg on 28.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import XCTest
@testable import TrubaPND77

class TrubaPND77Tests: XCTestCase {
    

    override func setUpWithError() throws {
       
    }

    override func tearDownWithError() throws {
        
    }

    func testRootViewControllerIsMainScreenViewController() {
        guard let sut = UIApplication.shared.windows.first else {
            XCTFail()
            return
        }
        
        let rootViewController = sut.rootViewController
        XCTAssertTrue(rootViewController is MainScreenViewController)
    }
    
    func testLayoutRootControllerIsFlowLayout() {
        guard let sut = UIApplication.shared.windows.first else {
            XCTFail()
            return
        }
        
        let rootViewController = sut.rootViewController as! MainScreenViewController
        XCTAssertTrue(rootViewController.collectionViewLayout is UICollectionViewFlowLayout)
    }

}
