//
//  NYCSchoolScore.swift
//  NYCSchools-DavidHomes-20211018
//
//  Created by dhomes on 10/19/21.
//

import Foundation

/// SchoolScore conforming type
struct NYCSchoolScore : SchoolScore {
    let dbn: String
    let schoolName: String
    let numOfSatTestTakers: String
    let satCriticalReadingAvgScore: String
    let satMathAvgScore: String
    let satWritingAvgScore: String
}
