//
//  MovieCardView.swift
//  MovieApp
//
//  Created by Ahmed Eltrass on 24/09/2025.
//

import SwiftUI
// MARK: - MovieCardView
struct MovieCardView: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            CustomImageView(
                imageURL: movie.posterPathFull,
                width: 280,
                height: 350,
                cornerRadius: 20
            )
            .shadow(radius: 10)
            
            Text(movie.title)
                .font(.headline)
                .foregroundColor(.white)
                .lineLimit(1)
            
            Text(movie.releaseDate ?? "")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}
