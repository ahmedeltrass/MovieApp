import SwiftUI

struct HomeScreen: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var mainRouter: Router<MainRoute>
    @State private var selectedTab: MovieCategory = .nowPlaying
    @State private var selectedMovie: Movie?

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                //  Background (first movie poster or black)
                if let movies = viewModel.movies[selectedTab], let firstMovie = movies.first {
                    CustomImageView(
                        imageURL: firstMovie.posterPathFull,
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height,
                        cornerRadius: 0,
                        isBlurred: true,
                        overlayColor: Color.black.opacity(0.5)
                    )
                    .ignoresSafeArea()
                } else {
                    Color.black.ignoresSafeArea()
                }

                //  Main content (carousel / error / empty message)
                VStack(spacing: 20) {
                    Spacer().frame(height: 120) // space for tab

                    if let movies = viewModel.movies[selectedTab], !movies.isEmpty {
                        MovieCarouselView(
                            movies: movies,
                            onMovieTap: { movie in
                                selectedMovie = movie
                                mainRouter.push(.movieDetailsScreen(id: movie.id))
                            }
                        )
                        .frame(height: 420)
                    } else if !viewModel.error.isEmpty {
                        Text("⚠️ \(viewModel.error)")
                            .foregroundColor(.red)
                            .padding()
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(12)
                    } else {
                        Text("No movies found for this category")
                            .foregroundColor(.white)
                            .font(.headline)
                    }

                    Spacer()
                }
                VStack {
                    TabSelectorView(selectedTab: $selectedTab) { category in
                        viewModel.fetchMovies(for: category)
                    }
                    .frame(height: 50)
                    .padding(.horizontal, 10)
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(12)
                    .padding(.top, 50)

                    Spacer()
                }
                .zIndex(1)

                //  Loading overlay
                if viewModel.loading {
                    ShowProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.3))
                        .zIndex(2)
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                // Load first tab only once
                if viewModel.movies[selectedTab] == nil {
                    viewModel.fetchMovies(for: selectedTab)
                }
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .environmentObject(Router<MainRoute>())
    }
}
