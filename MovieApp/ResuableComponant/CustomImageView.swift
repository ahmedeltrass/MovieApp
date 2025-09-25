//
//  CustomImageView.swift
//  MovieApp
//
//  Created by Ahmed Eltrass on 24/09/2025.
//

import SwiftUI
import Kingfisher

struct CustomImageView: View {
    let imageURL: String?
    let width: CGFloat?
    let height: CGFloat?
    let cornerRadius: CGFloat
    let isBlurred: Bool
    let overlayColor: Color?
    
    init(imageURL: String?,
         width: CGFloat? = nil,
         height: CGFloat? = nil,
         cornerRadius: CGFloat = 0,
         isBlurred: Bool = false,
         overlayColor: Color? = nil) {
        self.imageURL = imageURL
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.isBlurred = isBlurred
        self.overlayColor = overlayColor
    }
    
    var body: some View {
        ZStack {
            if let imageURL, let url = URL(string: imageURL) {
                KFImage(url)
                    .resizable()
                    .placeholder {
                        Color.gray
                            .overlay(
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            )
                    }
                    .onFailure { error in
                        print("Failed to load image: \(error.localizedDescription)")
                    }
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .cornerRadius(cornerRadius)
                    .blur(radius: isBlurred ? 20 : 0)
                    .overlay(overlayColor)
                    .clipped()
            } else {
                // Fallback إذا كان الـ URL فارغ
                Color.gray
                    .frame(width: width, height: height)
                    .cornerRadius(cornerRadius)
                    .overlay(overlayColor)
            }
        }
    }
}

