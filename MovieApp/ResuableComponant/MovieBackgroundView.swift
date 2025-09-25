//
//  MovieBackgroundView.swift
//  MovieApp
//
//  Created by Ahmed Eltrass on 24/09/2025.

import SwiftUI

struct MovieBackgroundView: View {
    let backdropPath: String?
    
    var body: some View {
        // استخدم CustomImageView بدل AsyncImage
        CustomImageView(
            imageURL: backdropPathFull,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height,
            cornerRadius: 0,
            isBlurred: true,
            overlayColor: Color.black.opacity(0.4)
        )
        .ignoresSafeArea()
    }
    
    // Helper لعمل رابط كامل للصورة
    private var backdropPathFull: String? {
        guard let backdropPath else { return nil }
        return "https://image.tmdb.org/t/p/w500\(backdropPath)"
    }
}
