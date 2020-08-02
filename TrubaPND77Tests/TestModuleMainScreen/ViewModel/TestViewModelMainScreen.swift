//
//  TestViewModelMainScreen.swift
//  TrubaPND77Tests
//
//  Created by Serg on 29.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import XCTest
@testable import TrubaPND77

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

   
    func testGeneratingItemsIsSuccessfulAndNumberOfRowsIsNotEmptyAndStateIsReadyToShowItems() {
        //given
        let itemsCount = EntityMocker.generateItem().count
        var state = ViewModelMainScreenState.initial
        var resutlCheckState = false
        
        //when
        sut.generateItems()
        sut.state.bind { (result) in
            state = result
        }
        
        switch state {
        case .readyToShowItems:
            resutlCheckState = true
        default:
            break
        }
        
        //then
        XCTAssert(itemsCount == sut.numberOfRows(), "Generating of items ended unsuccessfully")
        XCTAssert(resutlCheckState, "state view model did not change")
        
    }
    
    func testCellViewModelIsCreated() {
        //given
        guard let mockCellViewModel = EntityMocker.generateItem().first else {
            XCTFail()
            return
        }
        let indexPath = IndexPath(row: mockCellViewModel.key, section: 0)
        
        //when
        sut.generateItems()
        let result = sut.cellViewModel(forIndexPath: indexPath)
        
        //then
        XCTAssertNotNil(result, "cellViewModel is nil")
    }
    
    func testStateIsErrorOccureAndDescriptionOfError() {
        //given
        var descriptionError = ""
        let number = EntityMocker.wrongNumberOfItemsInDataBase()
        var state = ViewModelMainScreenState.initial
        var resutlCheckState = false
        
        //when
        sut.generateItems()
        _ = sut.cellViewModel(forIndexPath: IndexPath(row: number, section: 0))
        sut.state.bind { (result) in
            state = result
        }
        
        switch state {
        case .errorOccure(let error):
            resutlCheckState = true
            descriptionError = error
        default:
            break
        }
        
        //then
        XCTAssert(resutlCheckState, "state view model did not change")
        XCTAssert(descriptionError == unknownError, "error description is not correct")
    }
}
