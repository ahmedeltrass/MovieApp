import SwiftUI

struct MainNavHost: View {
    @StateObject var mainRouter: Router<MainRoute>
    var body: some View {
        VStack(spacing: 0) {
            router
        }
    }
    private var router: some View {
        NavigationHost(mainRouter) { path in
            switch path {
            case .splachScreen:
                SplashScreen()
            case .homeScreen:
                HomeScreen()
            case .movieDetailsScreen(id: let id):
                MovieDetailsScreen(movieId: id)
            }
        }
        .environmentObject(mainRouter)
    }
    
    init(initRoute: MainRoute? = .homeScreen) {
        self._mainRouter = StateObject(
            wrappedValue: Router(initial: initRoute, debug: false))
    }
}

struct MainNavHost_Previews: PreviewProvider {
    static var previews: some View {
        MainNavHost(initRoute: .homeScreen)
    }
}
