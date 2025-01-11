
import SwiftUI

struct ContentView: View {
    var body: some View {
        StartView()
    }
}

struct GameView: View {
    @Environment(\.dismiss) var dismiss // Use this to dismiss the current view
    
    // Track the colors of the rectangles
    @State private var colors: [[Color]] = []
    
    // Track matched rectangles
    @State private var matchedIndices: [(row: Int, column: Int)] = []
    
    // Track selected rectangles
    @State private var selectedIndices: [(row: Int, column: Int)] = []
    
    // Feedback message
    @State private var feedback: String = ""
    
    // Score and game state
    @State private var score: Int = 0
    @State private var isGameWon: Bool = false
    
    init() {
        _colors = State(initialValue: generateGrid())
    }
    
    var body: some View {
        VStack {
            if isGameWon {
                // Win Screen
                Text("You Win!")
                    .font(.largeTitle)
                    .foregroundColor(.green)
                    .padding()
                
                Text("Final Score: \(score)")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()
                
                Button(action: restartGame) {
                    Text("Restart Game")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .shadow(radius: 3)
                }
            } else {
                // Game Grid
                ForEach(0..<3, id: \.self) { row in
                    HStack {
                        ForEach(0..<3, id: \.self) { column in
                            Rectangle()
                                .fill(
                                    matchedIndices.contains(where: { $0 == (row, column) }) ? Color.gray :
                                    colors[row][column]
                                )
                                .frame(width: 100, height: 100)
                                .onTapGesture {
                                    if colors[row][column] != Color.black, // Ignore black rectangle
                                       !matchedIndices.contains(where: { $0 == (row, column) }) {
                                        handleTap(row: row, column: column)
                                    }
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(selectedIndices.contains(where: { $0 == (row, column) }) ? Color.blue : Color.clear, lineWidth: 3)
                                )
                                .opacity(matchedIndices.contains(where: { $0 == (row, column) }) ? 0.6 : 1.0)
                        }
                    }
                }
                
                // Display feedback and score
                Text(feedback)
                    .font(.headline)
                    .padding()
                    .foregroundColor(feedback == "Try Again!" ? .red : .blue)
                
                Text("Score: \(score)")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.green)
            }
        }
        .padding()
        .navigationTitle("Game")
        .navigationBarItems(leading: backButton) // Custom back button
    }
    
    private func handleTap(row: Int, column: Int) {
        if selectedIndices.contains(where: { $0 == (row, column) }) {
            return
        }

        selectedIndices.append((row, column))

        if selectedIndices.count == 2 {
            let first = selectedIndices[0]
            let second = selectedIndices[1]

            if colors[first.row][first.column] == colors[second.row][second.column] {
                matchedIndices.append(contentsOf: [first, second])
                score += 10

                if matchedIndices.count == 8 { // All pairs matched
                    isGameWon = true
                }
            } else {
                feedback = "Try Again!"
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    restartGame()
                }
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                selectedIndices.removeAll()
                if feedback == "Try Again!" { feedback = "" }
            }
        }
    }
    
    private func restartGame() {
        colors = generateGrid()
        matchedIndices.removeAll()
        selectedIndices.removeAll()
        feedback = ""
        score = 0
        isGameWon = false
    }
    
    private func generateGrid() -> [[Color]] {
        let allColors: [Color] = [.red, .green, .blue, .yellow]
        var colorPool = allColors.flatMap { [$0, $0] }
        colorPool.append(.black)
        colorPool.shuffle()
        
        var grid: [[Color]] = []
        for row in 0..<3 {
            var rowColors: [Color] = []
            for column in 0..<3 {
                rowColors.append(colorPool[row * 3 + column])
            }
            grid.append(rowColors)
        }
        
        return grid
    }
    
    // Custom Back Button
    private var backButton: some View {
        Button(action: {
            dismiss() // Dismiss the current view and go back to StartView
        }) {
            Text("")
                .foregroundColor(.blue)
        }
    }
}

#Preview {
    ContentView()
}
