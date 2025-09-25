//
//  MoviePosterView.swift
//  MovieApp
//
//  Created by Ahmed Eltrass on 24/09/2025.


import SwiftUI

struct MoviePosterView: View {
    let posterPath: String?
    let width: CGFloat? = 200
    let height: CGFloat = 300
    let cornerRadius: CGFloat = 16
    let shadowRadius: CGFloat = 10
    
    var body: some View {
        CustomImageView(
            imageURL: posterPathFull,
            width: width,
            height: height,
            cornerRadius: cornerRadius,
            isBlurred: false,
            overlayColor: nil
        )
        .shadow(radius: shadowRadius)
    }
    
    // Helper لعمل رابط كامل للصورة
    private var posterPathFull: String? {
        guard let posterPath else { return nil }
        return "https://image.tmdb.org/t/p/w500\(posterPath)"
    }
}
