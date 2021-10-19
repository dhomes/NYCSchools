//
//  NYCSchoolAPI.swift
//  20211018-DavidHomes-NYCSchools
//
//  Created by dhomes on 10/18/21.
//

import Foundation

/// API conforming type.
/// - View models expect Protocol-conforming types, so cocrete implementations can be easily swapped
struct NYCSchoolAPI : API {
    
    private let session = URLSession.shared
    func getSchools<T : School>() async throws -> [T] {
        guard let url = URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json") else {
            throw AppError.invalidUrl
        }
        let (data, _) = try await session.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let schools = try decoder.decode([T].self, from: data)
        return schools
    }
    
    func getScore<T : School, S : SchoolScore>(for school : T) async throws -> S? {
        guard let url = URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json?dbn=\(school.dbn)") else {
            throw AppError.invalidUrl
        }
        let (data, _) = try await session.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let scores = try decoder.decode([S].self, from: data)
        return scores.first
    }
}
