import Foundation
import Combine

// MARK: - ViewModel
class HomeViewModel: ObservableObject {
    @Published var movies: [MovieCategory: [Movie]] = [:]
    @Published var loading: Bool = false
    @Published var error: String = ""
    private var useCase: HomeUseCase?
    private var subs = Set<AnyCancellable>()
    
    func fetchMovies(for category: MovieCategory, page: Int = 1) {
        loading = true
        error = ""
        
        let useCase = HomeUseCase(category: category, page: page)
        
        useCase.execute(MovieResponse.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.loading = false
                if case let .failure(err) = completion {
                    self?.error = err.localizedDescription
                    print("Error fetching \(category.rawValue): \(err)")
                }
            } receiveValue: { [weak self] response in
                self?.movies[category] = response.results
            }
            .store(in: &subs)
    }
}
