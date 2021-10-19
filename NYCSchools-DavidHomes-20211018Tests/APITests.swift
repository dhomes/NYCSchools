//
//  APITests.swift
//  NYCSchools-DavidHomes-20211018Tests
//
//  Created by dhomes on 10/19/21.
//

import XCTest
@testable import NYCSchools_DavidHomes_20211018

class APITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }
    func testFetchingSchools() async throws {
        do {
            let school : [NYCSchool] = try await NYCSchoolAPI().getSchools()
            XCTAssert(school.count > 0)
            XCTAssert(school.count == 440)
        } catch {
            print(error)
        }
    }
    
    func testFetchingScore() async throws {
        do {
            let mockSchool = NYCSchool.mock()
            print(mockSchool.dbn)
            let score : NYCSchoolScore? = try await NYCSchoolAPI().getScore(for: mockSchool)
            XCTAssertNotNil(score)
        } catch {
            print(error)
        }
    }

}
