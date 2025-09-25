import SwiftUI

// MARK: - SplashScreen
struct SplashScreen: View {
    @State private var isActive = false
    @EnvironmentObject var mainRouter: Router<MainRoute>

    var body: some View {
        if isActive {
            // Navigate to Home after delay
            MainNavHost(initRoute: .homeScreen)
        } else {
            ZStack {
                // Background image with blur & overlay
                CustomImageView(
                    imageURL: "https://image.tmdb.org/t/p/w500/svXVRoRSu6zzFtCzkRsjZS7Lqpd.jpg",
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height,
                    cornerRadius: 0,
                    isBlurred: true,
                    overlayColor: Color.black.opacity(0.5)
                )
                .ignoresSafeArea()
                
                // App title
                Text("Movies App")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.7), radius: 5, x: 0, y: 2)
            }
            // Delay then navigate
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

// MARK: - Preview
struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
            .environmentObject(Router<MainRoute>())
    }
}
