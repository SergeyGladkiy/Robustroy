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
    
    //given
    var error = CustomError.initial
    var resultCheckError = false
    
    override func setUp() {
        super.setUp()
        sut = ModelMainScreen()
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
        var resultCheckStaticInfo = EntityMockerMainScreen.generateStaticInfromation()
        
        //when
        sut.processingStaticInformation()
        sut.staticInfо.bind { (data) in
            if data.isEmpty { return }
            resultCheckStaticInfo = data
        }
        
        //then
        XCTAssert(resultCheckStaticInfo == sut.staticInfо.observable, "Processing ended unsuccessfully")
    }
    
    func testErrorOccuredIsWrongFilePathAndBindingErrorOccuredWorks() {
        //MARK: rename file DataMainScreen.plist otherwise the path will be correct and the error will not work
        
        //when
        settingFunctionalityOfTestingModel()
        sut.processingStaticInformation()
        
        switch error {
        case .wrongFilePath:
            resultCheckError = true
        default:
            break
        }
        //then
        XCTAssert(resultCheckError, "Case CustomError is not .wrongFilePath")
        
    }
    
    func testErrorOccuredIsDecodingErrorAndBindingErrorOccuredWorks() {
        //MARK: change some in properties list of file DataMainScreen.plist otherwise the path will be correct and the error will not work
        
        //when
        settingFunctionalityOfTestingModel()
        sut.processingStaticInformation()
        
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
