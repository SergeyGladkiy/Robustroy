//
//  TestViewModelProductScreen.swift
//  TrubaPND77Tests
//
//  Created by Serg on 18.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import XCTest
@testable import Robustroy

class TestViewModelProductScreen: XCTestCase {
    
    var sut: ViewModelProductScreen!
    var model: ModelProductScreenMock!
    
    //given
    var checkStateIsError = false
    var errorOccured = ""
    
    override func setUp() {
        super.setUp()
        model = ModelProductScreenMock()
        sut = ViewModelProductScreen(model: model, state: .init(observable: .initial))
    }
    
    override func tearDown() {
        sut = nil
        model = nil
        super.tearDown()
    }
    
    private func settingBindingState() {
        sut.state.bind { [weak self] (state) in
            guard let self = self else { return }
            
            switch state {
            case .errorOccured(let error):
                self.checkStateIsError = true
                self.errorOccured = error
            default:
                break
            }
        }
    }
    
    func testGetInformationFromModelAndBindingWorksAndStateChangesInAsync() {
        //given
        let items = EntityMockerProductScreen.generateItemProduct()
        var checkStateIsReadyToShowItems = false
        var checkStateIsShowLoader = false
        let asyncProcessing = expectation(description: "Async Processing")
        let queue = DispatchQueue(label: "async", qos: .utility, attributes: .concurrent)
        
        //when
        sut.getInformation()
        sut.state.bind { (state) in
            switch state {
            case .showLoader:
                checkStateIsShowLoader = true
            case .readyToShowItems:
                checkStateIsReadyToShowItems = true
            default:
                break
            }
        }
        
        //then
        XCTAssertTrue(checkStateIsShowLoader, "The state is not .showLoader")
        
        queue.async { [weak self] in
            guard let self = self else { return }
            
            XCTAssertTrue(checkStateIsReadyToShowItems, "State did not change")
            XCTAssert(self.sut.numberOfRows() == items.descriptionProduct.count, "There are no items")
            
            asyncProcessing.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testStateIsErrorWhenErrorOccuresInModelAndModelErrorIsUnknown() {
        
        //when
        settingBindingState()
        model.errorOccured.observable = .unknown
        
        //then
        XCTAssertTrue(checkStateIsError, "State did not change")
        XCTAssert(errorOccured == unknownError, "The error is not .unknownError")
    }
    
    func testStateIsErrorWhenErrorIsOccuredInModelAndModelErrorIsNotConnectedToInternet() {
        //given
        let errorNotInternet = EntityMockerProductScreen.notConnectedToInternet
        
        //when
        settingBindingState()
        model.errorOccured.observable = .notConnectedToInternet
        
        //then
        XCTAssertTrue(checkStateIsError, "State did not change")
        XCTAssert(errorOccured == errorNotInternet, "The error is not .notConnectedToInternet")
    }
    
    func testCellViewModelAndCredentialAreCreated() {
        //given
        let index = EntityMockerProductScreen.correctIndex
        let indexPath = IndexPath(row: index, section: index)
        let asyncProcessing = expectation(description: "Async Processing")
        let queue = DispatchQueue(label: "async", qos: .utility, attributes: .concurrent)
        
        //when
        sut.getInformation()
        
        //then
        queue.async { [weak self] in
            guard let self = self else { return }
            XCTAssertNotNil(self.sut.cellViewModel(forIndexPath: indexPath), "cellViewModel was not created")
            asyncProcessing.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
}

