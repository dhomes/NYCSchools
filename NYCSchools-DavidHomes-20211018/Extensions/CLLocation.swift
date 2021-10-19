//
//  CLLocation.swift
//  Asura
//
//  Created by dhomes on 9/24/21.
//

import Foundation
import CoreLocation

// Convenience extension
extension CLLocation {
    var latitude: Double {
        return self.coordinate.latitude
    }
    
    var longitude: Double {
        return self.coordinate.longitude
    }
}
