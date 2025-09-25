//
//  Enums.swift
//  MovieApp
//
//  Created by Ahmed Eltrass on 24/09/2025.
//

enum MovieCategory: String, CaseIterable, Identifiable {
    case nowPlaying = "now_playing"
    case popular = "popular"
    case upcoming = "upcoming"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .nowPlaying: return "Now Playing"
        case .popular: return "Popular"
        case .upcoming: return "Upcoming"
        }
    }
}
