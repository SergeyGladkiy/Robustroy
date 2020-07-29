//
//  TestModelMainScreen.swift
//  TrubaPND77Tests
//
//  Created by Serg on 29.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import XCTest
@testable import TrubaPND77

class TestModelMainScreen: XCTestCase {
    
    var sut: ModelMainScreen!
    
    override func setUp() {
        super.setUp()
        sut = ModelMainScreen()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testDataOfItemsEqualThreeSection() {
        //given
        let quantityOfSections = 3
        
        //then
        XCTAssert(quantityOfSections == sut.numberOfItem(), "Неверное количество секций")
    }
    
    func testErrorOccureAndResultIsNil() {
        //given
        let initialError = ""
        let wrongNumberOfCountSections = 3
        
        //when
        let result = sut.dataOfItem(number: wrongNumberOfCountSections)
        
        
        //then
        XCTAssert(initialError != sut.errorOccure.observable, "Ошибка не сработала")
        XCTAssertNil(result, "Возвращаемое значение не nil")
        
    }
    
    func testResultDataOfItemIsNotNil() {
        //given
        let rightNumberOfCountSections = 2
        
        //when
        let result = sut.dataOfItem(number: rightNumberOfCountSections)
        
        //then
        XCTAssertNotNil(result, "Result is nil")
    }
}
