
import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) { // Add spacing between the buttons
                Text("Welcome to the Matching Game!")
                    .font(.largeTitle)
                    .padding()
                
                // Start Game Button
                NavigationLink(destination: GameView()) {
                    Text("Start Game")
                        .padding()
                        .frame(maxWidth: .infinity) // Make button fill horizontally
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .shadow(radius: 3)
                }
                
                // Guide Button
                NavigationLink(destination: GuideView())  {
                    Text("Guide")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .shadow(radius: 3)
                }
                
                // Highest Score Button
                NavigationLink(destination: HighestScoreView()) {
                    Text("Highest Score")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .shadow(radius: 3)
                }
                
                // Exit Button
                Button(action: exitApp) {
                    Text("Exit")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .shadow(radius: 3)
                }
            }
            .padding()
            .navigationTitle("Menu")
        }
    }
    
    // Function to show the guide
    private func showGuide() {
        print("Guide button tapped") // Replace with your guide logic or navigation
    }
    
    // Function to show the highest score
    private func showHighestScore() {
        print("Highest Score button tapped") // Replace with your logic to display the highest score
    }
    
    // Function to exit the app
    private func exitApp() {
        print("Exit button tapped") // Replace with exit logic, if required (Apps typically don't exit programmatically in iOS)
        // To force the app to terminate (not recommended for production apps):
        // exit(0)
    }
}

#Preview {
    StartView()
}
