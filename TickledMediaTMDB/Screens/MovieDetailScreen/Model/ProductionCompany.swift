//
//  ProductionCompany.swift
//  TickledMediaTMDB
//
//  Created by ds-mayur on 2/14/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

//Generated this model class using the https://app.quicktype.io/
// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int?
    let logoPath, name, originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}
