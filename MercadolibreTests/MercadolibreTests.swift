//
//  MercadolibreTests.swift
//  MercadolibreTests
//
//  Created by Mauricio Pacheco on 18-03-22.
//

import XCTest
@testable import Mercadolibre

class MercadolibreTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testMoney() throws {
        let valor: Double = 3050
        XCTAssertEqual("$ 3.050", valor.toPrice())
    }

    func testDiscount() throws {
        let valor: Double = 25
        XCTAssertEqual("25 % OFF", valor.toDiscount())
    }
}
