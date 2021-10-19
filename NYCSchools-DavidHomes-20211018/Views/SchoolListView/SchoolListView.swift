//
//  ContentView.swift
//  20211018-DavidHomes-NYCSchools
//
//  Created by dhomes on 10/18/21.
//

import SwiftUI

/// Main screen with list
struct SchoolListView: View {
    
    /*
     We'd nomally use private access level on a @StateObject
     but allowing it to be internal let us have both a default model or inject a custom one
     at init
     */
    @StateObject var model = SchoolListViewModel<NYCSchool>(api: NYCSchoolAPI())
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
                    // MARK: - FETCHING STATE
                    if model.isFetching {
                        Spacer()
                        ProgressView()
                        Spacer()
                    } else {
                        // MARK: - NO SCHOOLS RETRIEVES
                        if model.schools.isEmpty {
                            Spacer()
                            Text("Schools could not be retrieved")
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                            Spacer()
                        } else {
                            // MARK: - SCHOOL LIST
                            List(model.schools) { school in
                                NavigationLink(destination:
                                                SchoolDetailView(model: SchoolDetailViewModel(school: school,
                                                                                              api: model.api))
                                ) {
                                    VStack {
                                        SchoolRowView(school: school)
                                    }.padding(5)
                                }
                            }.refreshable {
                                Task {
                                    await model.refresh()
                                }
                            }
                        }
                    }
                }.navigationTitle("NYC Schools")
                    .onAppear {
                        Task {
                            await model.fetch()
                        }
                    }
                
            }
            .navigationViewStyle(.stack)
            .searchable(text: $model.search, prompt: "Search schools")
            .alert(isPresented: $model.hasError, content: {
                Alert(title: Text("Error"), message: Text(model.errorString), dismissButton: .default(Text("Continue")))
            })
            
        }
        
    }
}

struct SchoolListView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolListView()
    }
}
