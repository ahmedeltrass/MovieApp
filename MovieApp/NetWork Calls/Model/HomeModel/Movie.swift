//
//  Movie.swift
//  MoviesApp
//
//  Created by Ahmed_POMAC on 24/09/2025.
//

import Foundation

// MARK: - Movie Model
/// Represents a Movie object fetched from TMDb API
struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let releaseDate: String?    // Release date (optional)
    let posterPath: String?     // Poster image path (optional)
    
    // Coding keys to map JSON keys to Swift property names
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}
// MARK: - Movie model helper
extension Movie {
    var posterPathFull: String? {
        guard let posterPath else { return nil }
        return "https://image.tmdb.org/t/p/w500\(posterPath)"
    }
}
