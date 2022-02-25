//
//  SpaceXTests.swift
//  SpaceXTests
//
//  Created by Dillon Hoa on 16/07/2021.
//

import XCTest
@testable import SpaceX

class SpaceXTests: XCTestCase {
    
    var service: LaunchService = MockLaunchService()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetLaunches() throws {
        let vm = SpaceXLaunchViewModel()
        vm.service = service
        let exp = expectation(description: "Fail if too long")
        
        vm.didUpdateLaunches = {
            exp.fulfill()
            XCTAssert(vm.launches.count > 0)
        }
        vm.getLaunches()
         let result = XCTWaiter.wait(for: [exp], timeout: 2.0)
         if result == XCTWaiter.Result.timedOut {
             XCTFail("Did not get a result back in time")
         }
    }
    
    func testGetRockets() throws {
        let vm = SpaceXLaunchViewModel()
        vm.service = service
        let exp = expectation(description: "Fail if too long")
        
        vm.didUpdateLaunches = {
            exp.fulfill()
            vm.getRocket("TestRocket", completion: { rocket in
                XCTAssert(rocket.name != nil)
            })
        }
        vm.getLaunches()
         let result = XCTWaiter.wait(for: [exp], timeout: 2.0)
         if result == XCTWaiter.Result.timedOut {
             XCTFail("Did not get a result back in time")
         }
    }
    
    func testCompanyInfo() throws {
        let vm = SpaceXLaunchViewModel()
        vm.service = service
        let exp = expectation(description: "Fail if too long")
        
        vm.didUpdateCompanyInfo = {
            exp.fulfill()
            XCTAssert(vm.companyInfo != nil)
        }
        vm.getCompanyInfo()
         let result = XCTWaiter.wait(for: [exp], timeout: 2.0)
         if result == XCTWaiter.Result.timedOut {
             XCTFail("Did not get a result back in time")
         }
    }

}
