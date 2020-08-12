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
    
    //given
    var state = ViewModelMainScreenState.initial
    var resutlCheckState = false
    
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
    
    private func settingFunctionalityOfTestingViewModel() {
        sut.state.bind { [weak self] (result) in
            guard let self = self else {
                XCTFail()
                return
            }
            self.state = result
        }
    }
   
    func testGeneratingItemsIsSuccessfulAndNumberOfRowsIsNotEmptyAndStateIsReadyToShowItems() {
        //given
        let itemsCount = EntityMocker.generateItem().count
        
        //when
        sut.generateItems()
        settingFunctionalityOfTestingViewModel()

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
        
        
        //when
        sut.generateItems()
        _ = sut.cellViewModel(forIndexPath: IndexPath(row: number, section: 0))
        settingFunctionalityOfTestingViewModel()
        
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
    
    func testTwoWayDataBindingMockModelErrorOccureAndChangeStateViewModel() {
        //given
        let decodingError = CustomError.decodingError
        
        //when
        sut.twoWayDataBinding()
        mockModel.errorOccure.observable = decodingError
        settingFunctionalityOfTestingViewModel()
        
        switch state {
        case .errorOccure(_):
            resutlCheckState = true
        default:
            break
        }
        
        //then
        XCTAssert(resutlCheckState, "state view model did not change")
    }
    
    func testTwoWayDataBindingMockModelStaticInformationAndChangeStateViewModelAndQuantityOfDictionaryOfItemsIsNotZero() {
        //given
        let item = EntityMocker.generateItem()
        
        //when
        sut.twoWayDataBinding()
        mockModel.staticInfо.observable = item
        settingFunctionalityOfTestingViewModel()
        
        switch state {
        case .readyToShowItems:
            resutlCheckState = true
        default:
            break
        }
        
        //then
        XCTAssert(resutlCheckState, "state view model did not change")
        XCTAssert(item.count == sut.numberOfRows(), "The data is not edded in dectionaryOfItems")
    }
    
    func testTwoWayDataBindingAfterDeinitializationViewModelStateIsNotChanged() {
        //given
        let error = CustomError.decodingError
        let item = EntityMocker.generateItem()
        
        //when
        sut.twoWayDataBinding()
        settingFunctionalityOfTestingViewModel()
        sut = nil
        mockModel.staticInfо.observable = item
        mockModel.errorOccure.observable = error
        
        switch state {
        case .initial:
            resutlCheckState = true
        default:
            break
        }
        
        //then
        XCTAssert(resutlCheckState, "state view model did not change")
        
    }
}
