//
//  SchoolScore.swift
//  NYCSchools-DavidHomes-20211018
//
//  Created by dhomes on 10/19/21.
//

import Foundation

/// SchoolScore protocol
protocol SchoolScore : Decodable {
    var dbn : String { get }
    var schoolName : String { get }
    var numOfSatTestTakers : String { get }
    var satCriticalReadingAvgScore : String { get }
    var satMathAvgScore : String { get }
    var satWritingAvgScore : String { get }
}

