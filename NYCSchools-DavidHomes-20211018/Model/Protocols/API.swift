//
//  API.swift
//  20211018-DavidHomes-NYCSchools
//
//  Created by dhomes on 10/18/21.
//

import Foundation

/// Define a protocol for the APIs, models & view are to depend on protocols with conforming types injected at init
/// - Specially useful for unit testing so a Mock : Protocol can be injected
/// - We specify that conforming types are to use new async / await APIs
protocol API {
    func getSchools<T : School>() async throws -> [T]
    func getScore<T : School, S : SchoolScore>(for school : T) async throws -> S?
}
