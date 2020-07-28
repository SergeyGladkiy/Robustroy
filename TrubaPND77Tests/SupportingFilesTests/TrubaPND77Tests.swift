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

    func testRootViewControllerIsMainScreenViewController() throws {
        guard let sut = UIApplication.shared.windows.first else { return }
        let rootViewController = sut.rootViewController
        
        XCTAssertTrue(rootViewController is MainScreenViewController)
    }

}
