import SwiftUI

struct HardView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var colors: [[Color]] = []
    @State private var matchedIndices: [(row: Int, column: Int)] = []
    @State private var selectedIndices: [(row: Int, column: Int)] = []
    @State private var revealedIndices: [(row: Int, column: Int)] = []
    @State private var feedback: String = ""
    @State private var score: Int = 0
    @State private var isGameWon: Bool = false
    @State private var highestScore: Int = 0
    @State private var timeRemaining: Int = 120
    @State private var gameTime: Int = 0
    @State private var showAllSquares: Bool = true
    @State private var revealTime: Int = 5
    
    init() {
        _colors = State(initialValue: generateGrid())
    }
    
    var body: some View {
        VStack {
            if isGameWon {
                Text("You Win!")
                    .font(.largeTitle)
                    .foregroundColor(.green)
                    .padding()
                
                Text("Final Score: \(score)")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()
                
                Text("Time Taken: \(gameTime)s")
                    .font(.headline)
                    .foregroundColor(.orange)
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
                if showAllSquares {
                    Text("Showing colors for: \(revealTime)s")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.orange)
                } else {
                    Text("Time Remaining: \(timeRemaining)s")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.red)
                }
                
                ForEach(0..<5, id: \.self) { row in  // Updated from 4 to 5
                    HStack {
                        ForEach(0..<5, id: \.self) { column in  // Updated from 4 to 5
                            Rectangle()
                                .fill(
                                    matchedIndices.contains(where: { $0 == (row, column) }) ? Color.gray :
                                    (showAllSquares || revealedIndices.contains(where: { $0 == (row, column) })) ? colors[row][column] : Color.gray
                                )
                                .frame(width: 70, height: 70)
                                .onTapGesture {
                                    if !revealedIndices.contains(where: { $0 == (row, column) }),
                                       colors[row][column] != Color.black,
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
                
                Text(feedback)
                    .font(.headline)
                    .padding()
                    .foregroundColor(feedback == "Try Again!" ? .red : .blue)
                
                Text("Score: \(score)")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.blue)
                
                Text("Highest Score: \(highestScore)")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.green)
            }
        }
        .padding()
        .navigationTitle("Hard Game")
        .navigationBarItems(leading: backButton)
        .onAppear(perform: startInitialDelay)
    }
    
    private func startInitialDelay() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if revealTime > 0 {
                revealTime -= 1
            } else {
                showAllSquares = false
                timer.invalidate()
                startTimer()
            }
        }
    }
    
    private func startTimer() {
        gameTime = 0
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
                gameTime += 1
            } else {
                timer.invalidate()
                isGameWon = false
            }
        }
    }
    
    private func handleTap(row: Int, column: Int) {
        if selectedIndices.contains(where: { $0 == (row, column) }) {
            return
        }
        
        revealedIndices.append((row, column))
        selectedIndices.append((row, column))
        
        if selectedIndices.count == 2 {
            let first = selectedIndices[0]
            let second = selectedIndices[1]
            
            if colors[first.row][first.column] == colors[second.row][second.column] {
                matchedIndices.append(contentsOf: [first, second])
                score += 10
                
                if score > highestScore {
                    highestScore = score
                }
                
                if matchedIndices.count == 25 {  // Updated from 16 to 25
                    isGameWon = true
                }
            } else {
                feedback = "Try Again!"
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    revealedIndices.removeAll { $0 == first || $0 == second }
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
        revealedIndices.removeAll()
        feedback = ""
        score = 0
        isGameWon = false
        timeRemaining = 120
        gameTime = 0
        revealTime = 5
        showAllSquares = true
        startInitialDelay()
    }
    
    private func generateGrid() -> [[Color]] {
        let allColors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple, .pink, .cyan]
        var colorPool = allColors.flatMap { [$0, $0] }
        colorPool.shuffle()
        
        // Ensure we have enough colors for a 5x5 grid
        while colorPool.count < 25 {
            colorPool.append(contentsOf: colorPool)  // Duplicate to fill the grid
        }
        
        var grid: [[Color]] = []
        for _ in 0..<5 {  // Updated from 4 to 5
            var rowColors: [Color] = []
            for _ in 0..<5 {  // Updated from 4 to 5
                rowColors.append(colorPool.removeFirst())
            }
            grid.append(rowColors)
        }
        return grid
    }
    
    private var backButton: some View {
        Button(action: {
            dismiss()
        }) {
            Text("Back")
                .foregroundColor(.blue)
        }
    }
}

#Preview {
    HardView()
}

