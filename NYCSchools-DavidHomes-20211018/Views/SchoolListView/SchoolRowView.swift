//
//  SchoolRowView.swift
//  20211018-DavidHomes-NYCSchools
//
//  Created by dhomes on 10/19/21.
//

import SwiftUI
import MapKit

/// School Row for main screen's list
struct SchoolRowView<T : School>: View {
     let school : T
     var body: some View {
         ZStack {
             HStack {
                 VStack(alignment: .leading, spacing: 5) {
                     Text(school.schoolName).font(.system(.title2, design: .rounded)).fontWeight(.bold)
                     Text(school.location).font(.system(.subheadline)).foregroundColor(.gray).lineLimit(1)
                     Text(school.overviewParagraph).lineLimit(1)
                 }
                 Spacer()
             }.padding(.trailing)
              
         }
         
     }
}

struct SchoolRowView_Previews: PreviewProvider {
    static let school1 = NYCSchool.mock(withLatAndLong: true)
    static let school2 = NYCSchool.mock(withLatAndLong: false)
    static var previews: some View {
        SchoolRowView(school: school1).previewLayout(.fixed(width: 480, height: 150))
        SchoolRowView(school: school2).previewLayout(.fixed(width: 320, height: 80))
    }
}
