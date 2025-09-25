import SwiftUI

struct ShowProgressView: View {
    @State private var isAnimating = false
    @State private var pulse = false
    
    var body: some View {
        ZStack {
            // Background
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .blur(radius: 10)
            
            // Custom gradient progress
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                    .frame(width: 40, height: 40)
                
                Circle()
                    .trim(from: 0, to: 0.8)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [Color.purple, Color.pink]),
                            center: .center
                        ),
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )
                    .rotationEffect(.degrees(isAnimating ? 360 : 0))
                    .frame(width: 40, height: 40)
                    .animation(
                        Animation.linear(duration: 1).repeatForever(autoreverses: false),
                        value: isAnimating
                    )
            }
            .scaleEffect(pulse ? 1.5 : 1.2)
            .animation(
                Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true),
                value: pulse
            )
        }
        .onAppear {
            isAnimating = true
            pulse.toggle()
        }
    }
}

struct ShowProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ShowProgressView()
    }
}
