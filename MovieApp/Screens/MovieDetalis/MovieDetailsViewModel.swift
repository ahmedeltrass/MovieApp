//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Ahmed Eltrass on 24/09/2025.
//

import Foundation
import Combine

// MARK: - ViewModel
class MovieDetailsViewModel: ObservableObject {
    @Published var movie: MovieDetail?
    @Published var isLoading: Bool = false
    @Published var error: String = ""
    
    private var useCase: MovieDetailsUseCase?
    private var subs = Set<AnyCancellable>()
    
    // Fetch movie details by ID
    func fetchMovieDetail(id: Int) {
        isLoading = true
        error = ""
        
        let useCase = MovieDetailsUseCase(id: id)
        
        useCase.execute(MovieDetail.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(err) = completion {
                    self?.error = err.localizedDescription
                    print("Error fetching movie detail: \(err)")
                }
            } receiveValue: { [weak self] response in
                self?.movie = response
            }
            .store(in: &subs)
    }
}
