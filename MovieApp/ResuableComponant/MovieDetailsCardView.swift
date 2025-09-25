//
//  MovieDetailsCardView.swift
//  MovieApp
//
//  Created by Ahmed Eltrass on 24/09/2025.
//

/// Movie details card including title, info, genres, and overview
import SwiftUI

 struct MovieDetailsCardView: View {
    let movie: MovieDetail
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title
            Text(movie.title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .fixedSize(horizontal: false, vertical: true)
            
            // Info row
            HStack(spacing: 16) {
                Text("📅 \(movie.releaseDate)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                
                if let runtime = movie.runtime {
                    Text("⏱️ \(runtime) min")
                        .foregroundColor(.white)
                        .font(.subheadline)
                }
                
                Spacer()
                
                Text("⭐️ \(String(format: "%.1f", movie.voteAverage))/10")
                    .foregroundColor(.yellow)
                    .font(.subheadline)
            }
            
            // Genres
            if let genres = movie.genres, !genres.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(genres, id: \.id) { genre in
                            Text(genre.name)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.blue.opacity(0.3))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .font(.caption)
                        }
                    }
                }
                .frame(height: 32)
            }
            
            Divider()
                .background(Color.white.opacity(0.5))
                .padding(.vertical, 4)
            
            // Overview
            VStack(alignment: .leading, spacing: 8) {
                Text("Overview")
                    .font(.headline)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                
                Text(movie.overview)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.leading)
                    .lineSpacing(4)
            }
        }
        .padding(20)
        .background(Color.black.opacity(0.6))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        .frame(width: UIScreen.main.bounds.width - 40)
        .padding(.horizontal)
    }
}
