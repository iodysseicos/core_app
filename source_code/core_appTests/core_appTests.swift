//
//  core_appTests.swift
//  core_appTests
//
//  Created by Luis Silva on 28/03/24.
//

// @testable import core_app
// import XCTest
//
// final class CoreAppTests: XCTestCase {
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func test_CycleCalculation_DurarionOfNextCycle_Successful() {
//        // Given
//        let allDurations = [25, 26, 24, 28, 25]
//        let calculation = CycleCalculation()
//
//        // When
//        let nextCycleDuration = calculation.calculateWhenStartNextCycle(allDurations)
//
//        // Then
//        XCTAssertNotNil(nextCycleDuration, "O resultado não é nulo")
//        XCTAssertTrue(nextCycleDuration > 24)
//        XCTAssertTrue(nextCycleDuration < 27)
//        XCTAssertEqual(nextCycleDuration, 26) // 128 / 5 = 25.6 ~~ 26
//    }
//
//    func test_CycleCalculation_DayOfNextCycle_Successful() {
//        // Given
//        let calculation = CycleCalculation()
//
//        // When
//        let (day1, month1, year1) = calculation.calculateTheDayOfTheNextCycle(3, 3, 2024, 25)
//        let (day2, month2, year2) = calculation.calculateTheDayOfTheNextCycle(16, 2, 2024, 25)
//        let (day3, month3, year3) = calculation.calculateTheDayOfTheNextCycle(21, 1, 2024, 26)
//
//        // Then
//        XCTAssertNotNil(day1, "O resultado não é nulo")
//        XCTAssertNotNil(month1, "O resultado não é nulo")
//        XCTAssertNotNil(year1, "O resultado não é nulo")
//        XCTAssertEqual(day1, 28)
//        XCTAssertEqual(month1, 3)
//        XCTAssertEqual(year1, 2024)
//
//        XCTAssertNotNil(day2, "O resultado não é nulo")
//        XCTAssertNotNil(month2, "O resultado não é nulo")
//        XCTAssertNotNil(year2, "O resultado não é nulo")
//        XCTAssertEqual(day2, 12)
//        XCTAssertEqual(month2, 3)
//        XCTAssertEqual(year2, 2024)
//
//        XCTAssertNotNil(day3, "O resultado não é nulo")
//        XCTAssertNotNil(month3, "O resultado não é nulo")
//        XCTAssertNotNil(year3, "O resultado não é nulo")
//        XCTAssertEqual(day3, 16)
//        XCTAssertEqual(month3, 2)
//        XCTAssertEqual(year3, 2024)
//    }
// }
