//
//  TestViewModelCatalogScreen.swift
//  TrubaPND77Tests
//
//  Created by Serg on 18.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import XCTest
@testable import TrubaPND77

class TestViewModelCatalogScreen: XCTestCase {
    
    var sut: ViewModelCatalogScreen!
    var mockModel: ModelCatalogScreenMock!
    
    //given
    var state = ViewModelCatalogScreenState.initial
    var resutlCheckState = false
    
    override func setUp() {
        super.setUp()
        mockModel = ModelCatalogScreenMock()
        let state = Observable<ViewModelCatalogScreenState>(observable: .initial)
        sut = ViewModelCatalogScreen(state: state, model: mockModel)
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
        let itemsCount = EntityMockerCatalogScreen.generateItems().count
        
        //when
        sut.getCatalogInfo()
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
    
    func testCellViewModelAndDataForMenuViewAreCreated() {
        //given
        guard let mockCellViewModel = EntityMockerCatalogScreen.generateItems().first else {
            XCTFail()
            return
        }
        let indexPath = IndexPath(row: mockCellViewModel.key, section: 0)
        
        //when
        sut.getCatalogInfo()
        let result = sut.cellViewModel(forIndexPath: indexPath)
        let dataOfMenuView = sut.getInfoBarMenuView()
        
        //then
        XCTAssertFalse(dataOfMenuView.isEmpty, "Occure error by force unwrapped")
        XCTAssertNotNil(result, "cellViewModel is nil")
        
    }
    
    func testStateIsErrorOccuredAndDescriptionOfError() {
        //given
        var descriptionError = ""
        let number = EntityMockerCatalogScreen.wrongNumberOfItemsInDataBase()
        
        
        //when
        sut.getCatalogInfo()
        _ = sut.cellViewModel(forIndexPath: IndexPath(row: number, section: 0))
        settingFunctionalityOfTestingViewModel()
        
        switch state {
        case .errorOccured(let error):
            resutlCheckState = true
            descriptionError = error
        default:
            break
        }
        
        //then
        XCTAssert(resutlCheckState, "state view model did not change")
        XCTAssert(descriptionError == unknownError, "error description is not correct")
    }
    
    func testTwoWayDataBindingMockModelErrorOccuredAndChangeStateViewModel() {
        //given
        let decodingError = CustomError.decodingError
        
        //when
        //MARK: func twoWayDataBinding is call in init of viewModel
        mockModel.errorOccured.observable = decodingError
        settingFunctionalityOfTestingViewModel()
        
        switch state {
        case .errorOccured(_):
            resutlCheckState = true
        default:
            break
        }
        
        //then
        XCTAssert(resutlCheckState, "state view model did not change")
    }
    
    func testTwoWayDataBindingMockModelStaticInformationAndChangeStateViewModelAndQuantityOfDictionaryOfItemsIsNotZero() {
        //given
        let item = EntityMockerCatalogScreen.generateItems()
        
        //when
        //MARK: func twoWayDataBinding is call in init of viewModel
        mockModel.staticInfoCatalog.observable = item
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
        let item = EntityMockerCatalogScreen.generateItems()
        
        //when
        //MARK: func twoWayDataBinding is call in init of viewModel
        settingFunctionalityOfTestingViewModel()
        sut = nil
        mockModel.staticInfoCatalog.observable = item
        mockModel.errorOccured.observable = error
        
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

