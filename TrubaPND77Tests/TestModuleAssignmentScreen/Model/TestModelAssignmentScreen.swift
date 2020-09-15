//
//  TestModelAssignmentScreen.swift
//  TrubaPND77Tests
//
//  Created by Serg on 27.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import XCTest
@testable import TrubaPND77

class TestModelAssignmentScreen: XCTestCase {
    var sut: ModelAssignmentScreen!
    
    //given
    var errorOccured = false
    
    override func setUp() {
        super.setUp()
        let networking = NetworkAssignmentScreenMock()
        let mapper = MapperAssignmentScreenMock()
        sut = ModelAssignmentScreen(networking: networking, mapper: mapper)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    private func settingBindingErrorAndCustomizingByEnityMocker() {
        EntityMockerAssignmentScreen.isFailureComplition = true
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
        var resultCheckDataSource = EntityMockerAssignmentScreen.generateItemsAssignment()
        
        //when
        EntityMockerAssignmentScreen.isFailureComplition = false
        sut.fetchingInformation()
        sut.dataSource.bind { (data) in
            if data.isEmpty { return }
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
        
        //when
        EntityMockerAssignmentScreen.errorIsNotConnectionToNet = true
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

