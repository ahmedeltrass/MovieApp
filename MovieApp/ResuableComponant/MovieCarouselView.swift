//
//  MovieCarouselView.swift
//  MovieApp
//
//  Created by Ahmed Eltrass on 25/09/2025.
//
import SwiftUI

// MARK: - MovieCarouselView
struct MovieCarouselView: View {
    let movies: [Movie]
    var onMovieTap: (Movie) -> Void

    var body: some View {
        GeometryReader { geo in
            let screenWidth = geo.size.width

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(movies, id: \.id) { movie in
                        GeometryReader { itemGeo in
                            let midX = itemGeo.frame(in: .global).midX
                            let distance = abs(screenWidth / 2 - midX)
                            let scale = max(0.8, 1 - (distance / screenWidth) * 0.3)

                            MovieCardView(movie: movie)
                                .scaleEffect(scale)
                                .onTapGesture { onMovieTap(movie) }
                        }
                        .frame(width: 260, height: 400)
                    }
                }
                .padding(.horizontal, (screenWidth - 260) / 2)
            }
        }
    }
}
