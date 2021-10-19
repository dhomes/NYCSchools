//
//  School.swift
//  20211018-DavidHomes-NYCSchools
//
//  Created by dhomes on 10/18/21.
//

import Foundation

/// Define a protocol for the Schools, models & view are to depend on protocols
/// - Specially useful for unit testing so a Mock : Protocol can be injected
protocol School : Decodable, Hashable, Identifiable {
    var dbn : String { get }
    var schoolName : String { get }
    var boro : String { get }
    var overviewParagraph : String { get }
    var neighborhood : String { get }
    var location : String { get }
    var phoneNumber : String { get }
    var schoolEmail : String? { get }
    var website : String { get }
    var city : String { get }
    var zip : String { get }
    var stateCode : String { get }
    var latitude : Double? { get }
    var longitude : Double? { get }
    var borough : String? { get }
    var scores : SchoolScore? { get }
    mutating func setScores(_ scores : SchoolScore?)
}

// Identifiable & Hashable default implementation
extension School {
    func hash(into hasher: inout Hasher) {
        hasher.combine(dbn)
        hasher.combine(schoolName)
    }
    var id : Int {
        "\(dbn)\(schoolName)".hashValue
    }
}
