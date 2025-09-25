import SwiftUI

// MARK: - MovieDetailsScreen
struct MovieDetailsScreen: View {
    @StateObject private var viewModel = MovieDetailsViewModel()
    @EnvironmentObject private var mainRouter: Router<MainRoute>
    let movieId: Int
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                MovieBackgroundView(backdropPath: viewModel.movie?.backdropPath)
                    .ignoresSafeArea()
                
                // Content
                if viewModel.isLoading {
                    // Loading overlay
                    ShowProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.4))
                } else if let movie = viewModel.movie {
                    ScrollView {
                        VStack(spacing: 20) {
                            Spacer(minLength: 40)
                            MoviePosterView(posterPath: movie.posterPath)
                            MovieDetailsCardView(movie: movie)
                        }
                        .padding(.top, 20)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            // Navigation bar
            .navigationBarTitle("Movie Details", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Movie Details")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButtonView {
                        mainRouter.pop()
                    }
                }
            }
            // Fetch movie details on appear
            .task {
                viewModel.fetchMovieDetail(id: movieId)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
