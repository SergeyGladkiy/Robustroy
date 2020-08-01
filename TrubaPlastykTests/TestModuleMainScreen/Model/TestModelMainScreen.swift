//
//  TestModelMainScreen.swift
//  TrubaPND77Tests
//
//  Created by Serg on 29.07.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import XCTest
@testable import TrubaPlastyk

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

    func testStaticInforamtionIsGeneratedAndBindingStaticInfoWorks() {
        //given
        var resultCheckStaticInfo = [Int: ItemMainScreen]()
        
        //when
        sut.processingStaticInformation()
        sut.staticInfо.bind { (data) in
            resultCheckStaticInfo = data
        }
        //then
        
        XCTAssert(resultCheckStaticInfo == sut.staticInfо.observable, "Processing ended unsuccessfully")
    }
    
    func testErrorOccureIsWrongFilePathAndBindingErrorOccureWorks() {
        //MARK: rename file DataMainScreen.plist otherwise the path will be correct and the error will not work
        
        //given
        var error = CustomError.initial
        var resultCheckError = false
        
        //when
        sut.errorOccure.bind { (customError) in
            error = customError
        }
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
    
    func testErrorOccureIsDecodingErrorAndBindingErrorOccureWorks() {
        //MARK: change some in properties list of file DataMainScreen.plist otherwise the path will be correct and the error will not work
        
        //given
        var error = CustomError.initial
        var resultCheckError = false
        
        //when
        sut.errorOccure.bind { (customError) in
            error = customError
        }
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
