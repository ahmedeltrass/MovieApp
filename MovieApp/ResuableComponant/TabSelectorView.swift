//
//  TabSelectorView.swift
//  MovieApp
//
//  Created by Ahmed Eltrass on 25/09/2025.


import SwiftUI

struct TabSelectorView: View {
    @Binding var selectedTab: MovieCategory
    var onTabSelected: (MovieCategory) -> Void
    
    // تخزين التابات اللي اتعملها fetch
    @State private var loadedTabs: Set<MovieCategory> = []

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(MovieCategory.allCases, id: \.self) { category in
                    let isSelected = selectedTab == category

                    Text(category.displayName)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(isSelected ? .white : .gray.opacity(0.8))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(
                            Group {
                                if isSelected {
                                    LinearGradient(
                                        colors: [Color.purple, Color.pink],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                } else {
                                    Color.clear
                                }
                            }
                            .clipShape(Capsule())
                        )
                        .onTapGesture {
                            selectedTab = category
                            
                            // تحقق لو التاب ده محملش قبل كده
                            if !loadedTabs.contains(category) {
                                onTabSelected(category)
                                loadedTabs.insert(category)
                            }
                        }
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 50)
        .onAppear {
            // عند ظهور التاب لأول مرة، نعمل fetch لأول تاب محدد
            if !loadedTabs.contains(selectedTab) {
                onTabSelected(selectedTab)
                loadedTabs.insert(selectedTab)
            }
        }
    }
}
