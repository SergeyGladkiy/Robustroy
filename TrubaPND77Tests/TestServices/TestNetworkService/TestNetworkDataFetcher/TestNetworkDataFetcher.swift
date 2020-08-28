//
//  TestNetworkService.swift
//  TrubaPND77Tests
//
//  Created by Serg on 28.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import XCTest
@testable import TrubaPND77

class TestNetworkDataFetcher: XCTestCase {
    
    var sut: NetworkDataFetcher!
    
    //given
    var checkSuccesResponse = false
    var checkFailureResponse = false
    var errorOccured = NSURLError.timedOut
    
    override func setUp() {
        super.setUp()
        let networking = NetworkingMock()
        let mapper = MapperNetworkMock()
        sut = NetworkDataFetcher(networking: networking, mapper: mapper)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    private func settingCompletionHandlerAndCustomizingByEntityMocker(with setting: (Bool, Bool)) {
        let (networkRequestWithData, parseHtmlWithRepresentItems) = setting
        EntityMockerNetworkService.isNetworkingRequestCompletionWithData = networkRequestWithData
        EntityMockerNetworkService.isMapperParseHtmlCompletionWithRepresentItems = parseHtmlWithRepresentItems
        
        sut.fetchRepresentItems { [weak self] (response) in
            guard let self = self else { return }
            
            switch response {
            case .success(_):
                self.checkSuccesResponse = true
            case .failure(let error):
                self.checkFailureResponse = true
                self.errorOccured = error
            }
        }
    }
    
    func testDataNetworkRequestIsNotNilAndParseOfTheDataWasSuccessful() {
        //when
        self.settingCompletionHandlerAndCustomizingByEntityMocker(with: (true, true))
        
        //then
        XCTAssert(checkSuccesResponse, "Response is not .success")
    }
    
    func testDataNetworkRequestIsNotNilAndParseOfTheDataWasUnsuccessfulWithErrorParseHtml() {
        //given
        let verificationError = NSURLError.parseHtml
        
        //when
        settingCompletionHandlerAndCustomizingByEntityMocker(with: (true, false))
        
        //then
        XCTAssert(checkFailureResponse, "There is not .failure response in completionHadlere")
        XCTAssert(verificationError == errorOccured, "The error of failure is not .parseHtml")
    }
    
    func testErrorNetworkRequestIsNotNilAndMapperParsingBringUnknownError() {
        //given
        let verificationError = NSURLError.unknown
        
        //when
        //MARK: isMapperParseHtmlCompletionWithRepresentItems = true, In this case, there will be data and all assert will be wrong (p.s. for check)
        settingCompletionHandlerAndCustomizingByEntityMocker(with: (false, true))

        //then
        XCTAssert(checkFailureResponse, "There is not .failure response in completionHadlere")
        XCTAssert(verificationError == errorOccured, "The error of failure is not .unknown")
    }
}
