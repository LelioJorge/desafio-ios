//
//  Nasa.swift
//  desafio_ios
//
//  Created by Lelio Jorge on 29/03/21.
//

import Foundation

struct Nasa: Codable {
    var date: String
    var title: String
    var url: String
    var media: String
    
    private enum CodingKeys : String, CodingKey {
        case media = "media_type", date, title, url
        }
}
