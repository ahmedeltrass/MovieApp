//
//  MovieDetail.swift
//  MoviesApp
//
//  Created by Ahmed_POMAC on 24/09/2025.
//

import Foundation

// MARK: - MovieDetail Model
/// Represents detailed information about a Movie
struct MovieDetail: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let runtime: Int?
    let voteAverage: Double
    let posterPath: String?
    let backdropPath: String?
    let genres: [Genre]?
    
    // Coding keys to map JSON keys to Swift property names
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case releaseDate = "release_date"
        case runtime
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genres
    }
}

// MARK: - Genre Model
/// Represents a genre for a movie
struct Genre: Codable, Identifiable {
    let id: Int
    let name: String
}
