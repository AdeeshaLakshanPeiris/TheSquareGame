import SwiftUI

struct SelectView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.pink]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Select Difficulty")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    NavigationLink(destination: EasyView()) {
                        MenuButton(title: "Easy", color: .green)
                    }
                    
                    VStack(spacing: 15) {
                        NavigationLink(destination: MediumView())  {
                            MenuButton(title: "Medium", color: .yellow)
                        }
                        
                        Button(action: {
                            print("Hard selected")
                        }) {
                            MenuButton(title: "Hard", color: .red)
                        }
                    }
                    
                    Spacer()
                    
                    Text("Choose your challenge level and start the game!")
                        .font(.footnote)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.horizontal, 20)
            }
            .navigationBarTitle("Select Game", displayMode: .inline)
        }
    }
}
