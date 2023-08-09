//
//  Movie.swift
//  MovieRater
//
//  Created by Anders Pettersson on 2023-07-28.
//

import Foundation

struct MovieResponse: Decodable {
    
    let results: [Movie]
}


struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let backdrop_path: String?
    let poster_path: String?
    let overview: String
    let runtime: Int?
    let release_date: String?
    let genre: String?
    let origin_country: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id, title, backdrop_path, poster_path, overview, runtime, release_date, genre, origin_country
    }
}
