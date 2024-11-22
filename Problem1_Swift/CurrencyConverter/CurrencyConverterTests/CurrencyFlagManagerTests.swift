//
//  CurrencyFlagManagerTests.swift
//  CurrencyConverterTests
//
//  Created by Nhung Tran on 22/11/2024.
//

import XCTest
@testable import CurrencyConverter

final class CurrencyFlagManagerTests: XCTestCase {


    var sut: CurrencyFlagManager!  // System Under Test

    override func setUpWithError() throws {
        super.setUp()
        sut = CurrencyFlagManager.shared
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testJsonFileExists() {
        // Given
        let bundle = Bundle.main

        // When
        let url = bundle.url(forResource: "final_currencies", withExtension: "json")

        // Then
        XCTAssertNotNil(url, "JSON file should exist in the bundle.")
    }

    func testLoadCurrenciesSuccess() {
        // Given
        let expectedCount = 150

        // When
        sut.testableLoadCurrencies()

        // Then
        XCTAssertEqual(sut.currencies.count, expectedCount, "Should load \(expectedCount) currencies from JSON.")
    }

}
