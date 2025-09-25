//
//  BackButtonView.swift
//  MovieApp
//
//  Created by Ahmed Eltrass on 24/09/2025.
//

import SwiftUI
struct BackButtonView: View {
     let action: () -> Void    // أضف public هنا
    
     var body: some View {     // وأضف public هنا أيضاً
        Button(action: action) {
            Image(systemName: "chevron.left")
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        }
    }
    
    public init(action: @escaping () -> Void) {    // وأضف public هنا
        self.action = action
    }
}
