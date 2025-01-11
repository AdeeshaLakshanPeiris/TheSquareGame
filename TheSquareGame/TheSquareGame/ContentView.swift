
import SwiftUI

struct ContentView: View {
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
    
    // Game initialization
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
    }
    
    private func handleTap(row: Int, column: Int) {
        // If already selected, ignore the tap
        if selectedIndices.contains(where: { $0 == (row, column) }) {
            return
        }

        // Add to selected rectangles
        selectedIndices.append((row, column))

        // Check if two rectangles are selected
        if selectedIndices.count == 2 {
            let first = selectedIndices[0]
            let second = selectedIndices[1]

            // Check if colors match
            if colors[first.row][first.column] == colors[second.row][second.column] {
                matchedIndices.append(contentsOf: [first, second])
                score += 10 // Increase score for a correct match

                // Check if all rectangles are matched
                if matchedIndices.count == 8 { // 4 pairs matched (8 rectangles)
                    isGameWon = true
                }
            } else {
                feedback = "Try Again!" // Show "Try Again!" for mismatches
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    restartGame() // Restart the game on mismatch
                }
            }

            // Clear selected indices after delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                selectedIndices.removeAll()
                if feedback == "Try Again!" { feedback = "" } // Clear "Try Again!" after delay
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
        // Available colors
        let allColors: [Color] = [.red, .green, .blue, .yellow]
        
        // Create 4 pairs of matching colors
        var colorPool = allColors.flatMap { [$0, $0] }
        
        // Add one black rectangle
        colorPool.append(.black)
        
        // Shuffle the colors
        colorPool.shuffle()
        
        // Generate a 3x3 grid
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
}

#Preview {
    ContentView()
}

