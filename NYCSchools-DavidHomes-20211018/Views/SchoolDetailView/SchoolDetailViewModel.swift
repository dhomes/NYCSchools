//
//  SchoolDetailViewModel.swift
//  NYCSchools-DavidHomes-20211018
//
//  Created by dhomes on 10/19/21.
//

import Foundation
import MapKit

class SchoolDetailViewModel<T : School> : ObservableObject {
    
    /// API conforming type
    private let api : API
    
    /// Designated initializer
    /// - Parameters:
    ///   - school: School conforming type
    ///   - api: API conforming type
    init(school : T, api : API) {
        self.api = api
        self.school = school
    }
    
    /// The school
    @Published var school : T
    
    /// Whether we are fetching
    @Published var fetching = false
    
    /// Whether we have errors
    @Published var hasError = false
    
    /// Whether scores were retrieved (some schools do not have them)
    @Published var hasScores = false
    
    /// Get scores, using Swift concurrency
    @MainActor func getScores() async {
        do {
            fetching = true
            let scores : NYCSchoolScore? = try await api.getScore(for: school)
            school.setScores(scores)
            hasScores = scores != nil
            fetching = false
        } catch {
            self.error = error
            fetching = false
        }
    }
    
    /// Call school, will not work on simulator
    func call() {
        if let url = URL(string: "tel://\(school.phoneNumber)"),
        UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    /// Open website
    func website() {
        if let url = URL(string: "http://\(school.website)"),
        UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    /// Last stored error
    var error : Error?
}

extension SchoolDetailViewModel {
    var errorString : String {
        error?.localizedDescription ?? "n/a"
    }
    var scores : SchoolScore? {
        school.scores
    }
}

