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
    
    var sut: UIViewController!

    override func setUp() {
        super.setUp()
        obtainViewControllerFromUIAplicationWindow()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    private func obtainViewControllerFromUIAplicationWindow() {
        guard let keyWindow = UIApplication.shared.windows.first else {
            XCTFail()
            return
        }
        self.sut = keyWindow.rootViewController
    }
    
    func testRootViewControllerIsTabBarController() {
        //then
        XCTAssertTrue(sut is UITabBarController, "RootViewController is not UITabBarController")
    }
    
//    func testMainScreenViewControllerIsFirstViewControllerOfStackTabBarController() {
//        //when
//        guard let tabBarController = sut as? UITabBarController else {
//            XCTFail()
//            return
//        }
//        
//        //then
//        XCTAssertTrue(tabBarController.viewControllers?.first is UINavigationController, "MainScreenViewController is not first view controller of stack UITabBarController")
//    }
//    
//    func testLayoutRootControllerIsFlowLayout() {
//        guard let sut = UIApplication.shared.windows.first else {
//            XCTFail()
//            return
//        }
//        
//        let rootViewController = sut.rootViewController as! MainScreenViewController
//        XCTAssertTrue(rootViewController.collectionViewLayout is UICollectionViewFlowLayout)
//    }

}
