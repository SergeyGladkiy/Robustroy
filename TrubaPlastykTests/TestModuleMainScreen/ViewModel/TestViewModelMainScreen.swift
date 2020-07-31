//
//  TestViewModelMainScreen.swift
//  TrubaPND77Tests
//
//  Created by Serg on 29.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import XCTest
@testable import TrubaPlastyk

class TestViewModelMainScreen: XCTestCase {
    
    var sut: ViewModelMainScreen!
    var mockModel: ModelMainScreenMock!
    
    override func setUp() {
        super.setUp()
        mockModel = ModelMainScreenMock()
        let state = Observable<ViewModelMainScreenState>(observable: .initial)
        sut = ViewModelMainScreen(state: state, model: mockModel)
    }
    
    override func tearDown() {
        sut = nil
        mockModel = nil
        super.tearDown()
    }

   
    func testNumberOfItemsViewModelMainScreenIsThree() {
        //given
        let rightNumberOfQuantitySection = EntityMocker.generateCorrectQuantitySections()
        
        
        //when
        let result = sut.numberOfRows()
        
        //then
        XCTAssertTrue(rightNumberOfQuantitySection == result, "Не верное количество секций страницы")
    }
    
    func testCellViewModelForIndexPathIsFirsetAndIsNotNil() {
        //given
        let indexPath = IndexPath(item: 1, section: 0)
        let cellViewModel = EntityMocker.generateItemMainScreenForFirstSection()
        
        //when
        let result = sut.cellViewModel(forIndexPath: indexPath)
        
        //then
        XCTAssertNotNil(result, "cellViewModel is nil")
        XCTAssert(result!.titleGroup == cellViewModel.sectionName, "cellViewModel не для первой секции страницы")
    }
    
    func testErrorOccureAndStateViewModelMainScreenWasChanged() {
        //given
        let error = "error"
        
        //when
        mockModel.errorOccure.observable = error
        
        sut.state.bind { state in
            switch state {
            case .initial:
                XCTFail()
            case .errorOccure(let message):
                //then
                XCTAssert(error == message, "Состояние не изменилось, ошибка не сработала")
            }
        }
    }
}
