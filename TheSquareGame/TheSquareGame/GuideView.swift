import SwiftUI

struct GuideView: View {
    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 30) {
                    // Title
                    Text("📖 Game Instructions")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                        .padding(.top, 20)

                    // Subtitle
                    Text("Welcome to the Matching Game! Here's how to play:")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .multilineTextAlignment(.center)

                    // Instructions
                    Text("""
                    1. You will see a grid with colored rectangles.
                    2. The goal is to find matching pairs of colored rectangles.
                    3. Tap on two rectangles to reveal their colors.
                    4. If the colors match, they will stay visible.
                    5. If they don't match, they will be hidden again.
                    6. Keep matching pairs until you've matched them all!
                    7. Your score increases each time you find a match.
                    8. Good luck and have fun!
                    """)
                        .font(.body)
                        .foregroundColor(.white.opacity(0.9))
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                        .padding(.horizontal, 20)

                    Spacer()

                    // Back to Menu Button
                    NavigationLink(destination: StartView()) {
                        Text("Back to Menu")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(15)
                            .shadow(color: Color.green.opacity(0.5), radius: 7, x: 0, y: 5)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationBarTitle("Game Guide", displayMode: .inline)
    }
}

#Preview {
    GuideView()
}

