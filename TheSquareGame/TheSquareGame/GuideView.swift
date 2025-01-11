import SwiftUI



struct GuideView: View {
    var body: some View {
        VStack {
            Text("Game Instructions")
                .font(.largeTitle)
                .padding()
            
            Text("Welcome to the Matching Game! Here's how to play:")
                .font(.title2)
                .padding(.bottom, 20)
            
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
                .padding()
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            // Navigation to StartView
//            Button(action: {
//                // Close the guide and go back to StartView
////                NavigationUtil.popToRootView()
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
        .navigationBarTitle("Game Guide", displayMode: .inline)
    }
}
