//
//  NYCSchools_DavidHomes_20211018App.swift
//  NYCSchools-DavidHomes-20211018
//
//  Created by dhomes on 10/19/21.
//

import SwiftUI
/*
    Note:
    - Project can't have requested name YYYYMMDD_FirstLast_NYCSchools name format
    - SwiftUI Previews throw errors on project names starting with a number
    - Could use _YYYYMMDD or reserver convention, decided for the later
 */
@main
struct NYCSchools_DavidHomes_20211018App: App {
    var body: some Scene {
        WindowGroup {
            SchoolListView()
        }
    }
}
