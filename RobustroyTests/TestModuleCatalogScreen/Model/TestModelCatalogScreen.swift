//
//  TestModelCatalogScreen.swift
//  TrubaPND77Tests
//
//  Created by Serg on 18.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import XCTest
@testable import Robustroy

class TestModelCatalogScreen: XCTestCase {
    
    var sut: ModelCatalogScreen!
    
    //given
    var error = CustomError.initial
    var resultCheckError = false
    
    override func setUp() {
        super.setUp()
        sut = ModelCatalogScreen()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    private func settingFunctionalityOfTestingModel() {
        sut.errorOccured.bind { [weak self] (customError) in
            guard let self = self else { return }
            //MARK: not check on .initial
            self.error = customError
        }
    }

    func testStaticInforamtionIsGeneratedAndBindingStaticInfoWorks() {
        //given
        var resultCheckStaticInfo: [Int : ItemCatalogScreen]?
        
        //when
        sut.processingStaticData()
        sut.staticInfoCatalog.bind { (data) in
            if data.isEmpty { return }
            resultCheckStaticInfo = data
        }
        
        //then
        XCTAssert(resultCheckStaticInfo == sut.staticInfoCatalog.observable, "Processing ended unsuccessfully")
    }
    
    func testErrorOccuredIsWrongFilePathAndBindingErrorOccuredWorks() {
        //MARK: rename file DataCatalogScreen.plist otherwise the path will be correct and the error will not work
        
        //when
        settingFunctionalityOfTestingModel()
        sut.processingStaticData()
        
        switch error {
        case .wrongFilePath:
            resultCheckError = true
        default:
            break
        }
        //then
        XCTAssert(resultCheckError, "Case CustomError is not .wrongFilePath")
        
    }
    
    func testErrorOccuredIsDecodingAndBindingErrorOccuredWorks() {
        //MARK: change some in properties list of file DataCatalogScreen.plist otherwise the path will be correct and the error will not work
        
        //when
        settingFunctionalityOfTestingModel()
        sut.processingStaticData()
        
        switch error {
        case .decodingError:
            resultCheckError = true
        default:
            break
        }
        
        //then
        XCTAssert(resultCheckError, "Case CustomError is not .decodingError")
    }
}

