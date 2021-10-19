//
//  AsuraStore+Extensions.swift
//  Asura
//
//  Created by dhomes on 10/19/21.
//

import Foundation
import SwiftUI
import MapKit

// Mapkit related extension
extension School {
    
    /// Whether the school has latitude & longitude
    var hasCoodinate : Bool {
        latitude != nil && longitude != nil
    }
    
    /// optional CLLocationCoordinate
    var coordinate : CLLocationCoordinate2D? {
        if let lat = latitude, let lon = longitude {
            return CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        return nil
    }
}

/// Annotation type for map
enum AnnotationType {
    case pin(tint: Color)
    case marker(tint: Color)
    case flag(tint: Color)
}

/// School Annotation for map
struct SchoolAnnotation<T : School> : Identifiable {
    
    let school : T
    var markType : AnnotationType
    var id : Int {
        school.id
    }
 
    init?(school : T, markType : AnnotationType) {
        guard school.hasCoodinate else {
            return nil
        }
        self.school = school
        self.markType = markType
        self.coordinate = school.coordinate!
    }
    
    var coordinate : CLLocationCoordinate2D
    var mark : AnyMapAnnotationProtocol  {
      switch markType {
          
      case .pin(tint: let tint):
        return AnyMapAnnotationProtocol(MapPin(coordinate: coordinate, tint: tint))
      
      case .marker(tint: let tint):
        return AnyMapAnnotationProtocol(MapMarker(coordinate: coordinate, tint: tint))
      
      case .flag(tint: let tint):
        return AnyMapAnnotationProtocol(MapAnnotation(coordinate: coordinate) {
            VStack(alignment: .leading) {
                Text(school.schoolName).bold().font(.system(size: 14))
                Text(school.location).font(.system(size: 12))
            }
            .padding(5)
            .background(tint.cornerRadius(10))
          })
      }
    }
}

/// Annotation mark type erasure
struct AnyMapAnnotationProtocol: MapAnnotationProtocol { // 1
  let _annotationData: _MapAnnotationData // 2
  let value: Any // 3

  init<WrappedType: MapAnnotationProtocol>(_ value: WrappedType) { // 4
    self.value = value
    _annotationData = value._annotationData // 5
  }
}

