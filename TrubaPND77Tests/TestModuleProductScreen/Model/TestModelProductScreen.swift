//
//  TestModelProductScreen.swift
//  TrubaPND77Tests
//
//  Created by Serg on 18.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import XCTest
@testable import TrubaPND77

class TestModelProductScreen: XCTestCase {
    var sut: ModelProductScreen!
    
    //given
    var errorOccured = false
    
    override func setUp() {
        super.setUp()
        let networking = NetworkProductScreenMock()
        let mapper = MapperProductScreenMock()
        sut = ModelProductScreen(networking: networking, mapper: mapper)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    private func settingBindingErrorAndCustomizingByEnityMocker() {
        EntityMockerProductScreen.isFailureComplition = true
        sut.fetchingInformation()
        sut.errorOccured.bind { [weak self] error in
            guard let self = self else { return }
            
            switch error {
            case .initial:
                return
            default:
                self.errorOccured = true
            }
        }
    }
    
    func testDataSourceIsGotAndBindingDataSourceWorks() {
        //given
        var resultCheckDataSource: ItemProductScreen?
        
        //when
        EntityMockerProductScreen.isFailureComplition = false
        sut.fetchingInformation()
        sut.dataSource.bind { (data) in
            if data == nil { return }
            resultCheckDataSource = data
        }
        
        //then
        XCTAssert(resultCheckDataSource == sut.dataSource.observable, "Fetching ended unsuccessfully")
    }
    
    func testErrorOccuredAndBindingErrorWorks() {
        //when
        self.settingBindingErrorAndCustomizingByEnityMocker()

        //then
        XCTAssert(errorOccured, "Error did not occur")
    }
    
    func testErrorOccuredAndTheErrorIsNotConnectionToNet() {
        //given
        var resultCheckErrorIsEqualNotConnectionToNet = false
        EntityMockerProductScreen.errorIsNotConnectionToNet = true
        
        //when
        self.settingBindingErrorAndCustomizingByEnityMocker()
        
        switch sut.errorOccured.observable {
        case .notConnectedToInternet:
            resultCheckErrorIsEqualNotConnectionToNet = true
        default:
            break
        }
        
        //then
        XCTAssert(errorOccured, "Error did not occur")
        XCTAssert(resultCheckErrorIsEqualNotConnectionToNet, "The error is not  .notConnectedToInternet")
    }
}
