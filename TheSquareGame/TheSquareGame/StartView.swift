import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Gradient background with overlay pattern
                LinearGradient(gradient: Gradient(colors: [Color.indigo, Color.teal]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                VStack(spacing: 40) { // Increased spacing for a more airy design
                    // App Title
                    Text("🎮 Matching Game")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)

                    // Decorative Image with animation
                    Image(systemName: "puzzlepiece.extension")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                        .rotationEffect(Angle(degrees: 10))

                    Spacer()

                    // Buttons
                    VStack(spacing: 25) {
                        NavigationLink(destination: SelectView()) {
                            MenuButton(title: "Start Game", color: .blue)
                        }

                        NavigationLink(destination: GuideView()) {
                            MenuButton(title: "Guide", color: .green)
                        }

                        NavigationLink(destination: HighestScoreView()) {
                            MenuButton(title: "Highest Score", color: .orange)
                        }

                        Button(action: exitApp) {
                            MenuButton(title: "Exit", color: .red)
                        }
                    }

                    Spacer()

                    // Footer Text
                    Text("© 2025 Matching Game Co.")
                        .font(.footnote)
                        .foregroundColor(.white.opacity(0.7))
                }
                .padding(.horizontal, 20)
            }
            .navigationBarHidden(true)
        }
    }

    // Function to exit the app
    private func exitApp() {
        print("Exit button tapped") // Placeholder for exit logic
    }
}

// Reusable Menu Button Component
struct MenuButton: View {
    let title: String
    let color: Color

    var body: some View {
        Text(title)
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(color)
            .cornerRadius(15)
            .shadow(color: color.opacity(0.5), radius: 7, x: 0, y: 5)
    }
}

#Preview {
    StartView()
}

