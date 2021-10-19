//
//  SchoolDetailView.swift
//  NYCSchools-DavidHomes-20211018
//
//  Created by dhomes on 10/19/21.
//

import SwiftUI
import MapKit

/// School detail view
struct SchoolDetailView<T : School>: View {
    
    /// Injected generalized model
    @ObservedObject var model : SchoolDetailViewModel<T>
    
    /// current light / dark mode
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(showsIndicators: false) {
                // MARK: - MAP
                ZStack(alignment: .bottomLeading) {
                    Unwrap(model.school.coordinate) { coordinate in
                        Map(coordinateRegion: .constant(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.0075, longitudeDelta: 0.0075))),
                            interactionModes: [] ,
                            showsUserLocation: false,
                            userTrackingMode: .constant(.none), annotationItems: [model.school]) { School in
                            SchoolAnnotation(school: model.school,
                                             markType: .pin(tint: .red))!.mark
                        }.frame(width: geo.size.width,
                                height: 250)
                    }
                    // MARK: - SCHOOL NAME
                    HStack {
                        Text(model.school.schoolName)
                            .font(.system(.title,
                                          design: .rounded))
                            .bold()
                            .padding(.horizontal)
                        Spacer()
                    }.frame(width: geo.size.width)
                        .padding(.vertical,5)
                        .background(colorScheme == .light ? .white.opacity(0.85) : .black.opacity(0.6))
                        .overlay(Rectangle()
                                    .stroke(colorScheme == .light ? .black : .gray, lineWidth: 0.5))

                }
                
                // MARK: - LOCATION
                HStack() {
                    Text(model.school.location).padding(.horizontal).lineLimit(2)
                    Spacer()
                }.frame(width: geo.size.width)
                
                // MARK: - ACTION BUTTONS
                HStack {
                    Button {
                        model.website()
                    } label: {
                        VStack {
                            Image(systemName: "network").imageScale(.large)
                            Text("Website")
                        }.padding(10).background(.white.opacity(0.8)).cornerRadius(10)
                    }
                    Button {
                        model.call()
                    } label: {
                        VStack {
                            Image(systemName: "phone").imageScale(.large)
                            Text("Phone")
                        }.padding(10).background(.white.opacity(0.8)).cornerRadius(10)
                    }
                    Spacer()
                }.padding(.horizontal)
                
                // MARK: - SAT SCORES
                VStack(alignment: .leading, spacing: 10) {
                    
                    if model.fetching {
                        ProgressView()
                    } else {
                        if model.hasScores {
                            Text("Average SAT scores").font(.system(.title2)).fontWeight(.bold)
                            Divider()
                            Unwrap(model.scores) { scores in
                                VStack(spacing: 10) {
                                    HStack {
                                        Text("Number of test takers").fontWeight(.medium)
                                        Spacer()
                                        Text(scores.numOfSatTestTakers).fontWeight(.medium)
                                    }
                                    Divider()
                                    HStack {
                                        Text("Critical reading").fontWeight(.medium)
                                        Spacer()
                                        Text(scores.satCriticalReadingAvgScore).fontWeight(.medium)
                                    }
                                    Divider()
                                    HStack {
                                        Text("Math").fontWeight(.medium)
                                        Spacer()
                                        Text(scores.satMathAvgScore).fontWeight(.medium)
                                    }
                                    Divider()
                                    HStack {
                                        Text("Writing").fontWeight(.medium)
                                        Spacer()
                                        Text(scores.satWritingAvgScore).fontWeight(.medium)
                                    }
                                }
                            }
                        } else {
                            // MARK: - SCORES NOT AVAILABLE
                            HStack {
                                Spacer()
                                Text("School scores not available").font(.system(.body)).fontWeight(.bold).foregroundColor(.white)
                                Spacer()
                            }.padding().background(.red).cornerRadius(10)
                            
                        }
                    }
                    Divider()
                    
                    // MARK: - OVERVIEW
                    Text("Overview").font(.system(.title2)).fontWeight(.bold)
                    Text(model.school.overviewParagraph).foregroundColor(.brown)

                    Spacer()
                }.padding()
            }
            .alert(isPresented: $model.hasError, content: {
                Alert(title: Text("Error"), message: Text(model.errorString), dismissButton: .default(Text("Continue")))
            })
            .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    Task {
                        await model.getScores()
                    }
            }
        }
    }
}

struct SchoolDetailView_Previews: PreviewProvider {
    static let school = NYCSchool.mock(withLatAndLong: true)
    static let model = SchoolDetailViewModel(school: NYCSchool.mock(withLatAndLong: true), api:  NYCSchoolAPI())
    static var previews: some View {
        SchoolDetailView(model: model)
    }
}
