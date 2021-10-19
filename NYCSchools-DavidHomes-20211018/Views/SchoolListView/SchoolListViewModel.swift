//
//  SchoolListViewModel.swift
//  NYCSchools-DavidHomes-20211018
//
//  Created by dhomes on 10/19/21.
//

import Foundation

/// Generalized School list view model
class SchoolListViewModel<T : School> : ObservableObject {
    
    
    /// Injected api
    /// - Not private so we can forward it to the detail screen
    let api : API
    
    
    /// All retrieved schools
    /// - For timing, we are skipping pagination
    private var allSchools : [T] = [] {
        didSet {
            setSchools()
        }
    }
    
    /// The Schools the view feeds off
    @Published var schools : [T] = []
    
    /// Search string
    @Published var search = "" {
        didSet {
            setSchools()
        }
    }
    
    /// Called when allSchools or Search change
    private func setSchools() {
        guard search.count > 0 else {
            schools = allSchools
            return
        }
        let lowersearch = search.lowercased()
        schools = allSchools.filter { $0.schoolName.lowercased().contains(lowersearch)}
    }
    
    /// Designated initializer
    init(api : API) {
        self.api = api
    }
    
    /// Whether there is an error
    @Published var hasError = false

    
    /// Whether we are fetching
    @Published var isFetching = false
    
    /// Any present error
    var error : Error? {
        didSet {
            hasError = error != nil
        }
    }
    
    /// fetch data using new Concurrency APIs
    @MainActor func fetch() async {
        guard allSchools.count == 0 else {
            return
        }
        do {
            isFetching = true
            async let schools : [T] = try await api.getSchools()
            self.allSchools = try await schools
            isFetching = false
        } catch {
            self.error = error
            self.isFetching = true
        }
    }

    /// refreshes data using new Concurrency APIs
    @MainActor func refresh() async {
        do {
            async let schools : [T] = try await api.getSchools()
            self.allSchools = try await schools
        } catch {
            self.error = error
        }
    }
}

extension SchoolListViewModel {
    var errorString : String {
        error?.localizedDescription ?? ""
    }
}
