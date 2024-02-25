//
//  IPViewModelTest.swift
//  FindMyIPTests
//
//  Created by Jayamurugan on 10/02/24.
//

import XCTest
@testable import FindMyIP

final class IPViewModelTest: XCTestCase {
  private var viewModel: IPAddressViewModel?


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      self.viewModel = nil
    }

  func testFetchIPAddressSuccess() {
    let expectedResult: String = "2406:7400:c6:87ae:ac53:1cee:ef1a:b33c"

    self.viewModel = IPAddressViewModel(networkManager: MockIPNetworkManager(failureCase: false))

    let expectation = self.expectation(description: "Fetch IP Address")
    self.viewModel?.fetchIPAddress()

    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
      XCTAssertEqual(self.viewModel?.ipAddress ?? "", expectedResult)
      XCTAssertEqual(self.viewModel?.isLoading, false)
      XCTAssertEqual(self.viewModel?.errorMessage, "")
      expectation.fulfill()
    }
    waitForExpectations(timeout: 10.0, handler: nil)
  }

  func testFetchIPAddressFailure() {
    let expectedResult: String = ""

    self.viewModel = IPAddressViewModel(networkManager: MockIPNetworkManager(failureCase: true))

    let expectation = self.expectation(description: "Fetch IP Address")
    self.viewModel?.fetchIPAddress()

    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
      XCTAssertEqual(self.viewModel?.ipAddress ?? "", expectedResult)
      XCTAssertEqual(self.viewModel?.isLoading, true)
      XCTAssertNotNil(self.viewModel?.errorMessage)
      expectation.fulfill()
    }
    waitForExpectations(timeout: 10.0, handler: nil)
  }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
