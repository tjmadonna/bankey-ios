//
//  CurrencyFormatterTests.swift
//  BankeyUnitTests
//
//  Created by Tyler Madonna on 8/28/22.
//

import Foundation
import XCTest

@testable import Bankey

class CurrencyFormatterTests: XCTestCase {

    var sut: CurrencyFormatter!

    var localCurrentSymbol: String {
        return Locale.current.currencySymbol!
    }

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CurrencyFormatter()
    }

    func testBreakDollarsIntoCents() throws {
        // Act
        let result = sut.breakIntoDollarsAndCents(929466.23)

        // Assert
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }

    func testDollarsFormatted() throws {
        // Act
        let result = sut.dollarsFormatted(929466.23)

        // Assert
        XCTAssertEqual(result, "$929,466.23")
    }

    func testZeroDollarsFormatted() throws {
        // Act
        let result = sut.dollarsFormatted(0)

        // Assert
        XCTAssertEqual(result, "$0.00")
    }

}
