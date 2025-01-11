import SwiftUI

struct HighestScoreView: View {
    // Retrieve the highest score from UserDefaults
    let highestScore: Int = UserDefaults.standard.integer(forKey: "HighestScore")
    
    var body: some View {
        VStack {
            Text("Highest Score")
                .font(.largeTitle)
                .padding()
            
            Text("Your highest score is: \(highestScore)")
                .font(.title)
                .padding()
            
            Spacer()
            
            // Navigation to StartView
//            Button(action: {
//                // Close the current view and go back to the StartView
//                NavigationUtil.popToRootView()
//            }) {
//                Text("Back to Start")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//                    .shadow(radius: 3)
//            }
//            .padding(.bottom, 20)
        }
        .padding()
        .navigationBarTitle("Highest Score", displayMode: .inline)
    }
}


