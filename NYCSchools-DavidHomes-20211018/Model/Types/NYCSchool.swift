//
//  NYCSchool.swift
//  20211018-DavidHomes-NYCSchools
//
//  Created by dhomes on 10/18/21.
//

import Foundation

/// School conforming type
struct NYCSchool : School, Decodable {
    
    let dbn : String
    let schoolName : String
    let boro : String
    let overviewParagraph : String
    let neighborhood : String
    let buildingCode : String?
    let location : String
    let phoneNumber : String
    let schoolEmail : String?
    let website : String
    let city : String
    let zip : String
    let stateCode : String
    let latitude : Double?
    let longitude : Double?
    let borough : String?
    var scores : SchoolScore? = nil
    
    /// Custom Decodable initializer, the latitudes & longitudes come as Strings, need to convert to Double
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dbn = try container.decode(String.self, forKey: .dbn)
        self.schoolName = try container.decode(String.self, forKey: .schoolName)
        self.boro = try container.decode(String.self, forKey: .boro)
        self.overviewParagraph = try container.decode(String.self, forKey: .overviewParagraph)
        self.neighborhood = try container.decode(String.self, forKey: .neighborhood)
        self.buildingCode = try? container.decode(String.self, forKey: .buildingCode)
        self.location = try container.decode(String.self, forKey: .location)
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        self.schoolEmail = try? container.decode(String.self, forKey: .schoolEmail)
        self.website = try container.decode(String.self, forKey: .website)
        self.city = try container.decode(String.self, forKey: .city)
        self.zip = try container.decode(String.self, forKey: .zip)
        self.stateCode = try container.decode(String.self, forKey: .stateCode)
        self.borough = try? container.decode(String.self, forKey: .borough)
        
        if let latitudeString = try? container.decode(String.self, forKey: .latitude),
            let latitude = Double(latitudeString) {
            self.latitude = latitude
        } else {
            self.latitude = nil
        }
        
        if  let longitudeString = try? container.decode(String.self, forKey: .longitude),
                let longitude = Double(longitudeString) {
            self.longitude = longitude
        } else {
            self.longitude = nil
        }
    }

    static func == (lhs: NYCSchool, rhs: NYCSchool) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    private init(dbn : String,
                 schoolName : String,
                 boro : String,
                 overview : String,
                 neighborhood : String,
                 buildingCode : String?,
                 location : String,
                 phoneNumber : String,
                 schoolEmail : String?,
                 website : String,
                 city : String,
                 zip : String,
                 stateCode : String,
                 latitude : Double?,
                 longitude : Double?,
                 borough : String?) {
        
        self.dbn = dbn
        self.schoolName = schoolName
        self.boro = boro
        self.overviewParagraph = overview
        self.neighborhood = neighborhood
        self.buildingCode = buildingCode
        self.location = location
        self.phoneNumber = phoneNumber
        self.schoolEmail = schoolEmail
        self.website = website
        self.city = city
        self.zip = zip
        self.stateCode = stateCode
        self.latitude = latitude
        self.longitude = longitude
        self.borough = borough
    }
    
    mutating func setScores(_ scores : SchoolScore?) {
        self.scores = scores
    }
}

/// Coding keys
extension NYCSchool {
    enum CodingKeys : String, CodingKey {
        case dbn
        case schoolName
        case boro
        case overviewParagraph  
        case neighborhood
        case buildingCode
        case location
        case phoneNumber
        case schoolEmail
        case website
        case directions1
        case city
        case zip
        case stateCode  
        case latitude
        case longitude
        case borough
    }
}

extension NYCSchool {
    static func mock(withLatAndLong lal: Bool = false) -> NYCSchool {
        NYCSchool(dbn: "31R080",
                  schoolName: "Clinton School Writers & Artists, M.S. 260", boro: "M", overview: "Students who are prepared for college must have an education that encourages them to take risks as they produce and perform. Our college preparatory curriculum develops writers and has built a tight-knit community. Our school develops students who can think analytically and write creatively. Our arts programming builds on our 25 years of experience in visual, performing arts and music on a middle school level. We partner with New Audience and the Whitney Museum as cultural partners. We are a International Baccalaureate (IB) candidate school that offers opportunities to take college courses at neighboring universities.", neighborhood: "Chelsea-Union Sq", buildingCode: "M868", location: "10 East 15th Street, Manhattan NY 10003 (40.736526, -73.992727)", phoneNumber: "212-524-4360", schoolEmail: "admissions@theclintonschool.net", website: "www.theclintonschool.net", city: "Manhattan", zip: "10003", stateCode: "NY", latitude: lal ? 40.73653 : nil, longitude: lal ? -73.9927 : nil, borough: "MANHATTAN")
    }
}
