import SwiftUI

struct MediumView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var colors: [[Color]] = []
    @State private var matchedIndices: [(row: Int, column: Int)] = []
    @State private var selectedIndices: [(row: Int, column: Int)] = []
    @State private var revealedIndices: [(row: Int, column: Int)] = []
    @State private var feedback: String = ""
    @State private var score: Int = 0
    @State private var isGameWon: Bool = false
    @State private var timeRemaining: Int = 60
    @State private var revealTime: Int = 3
    @State private var showAllSquares: Bool = true
    
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
                
                ForEach(0..<4, id: \ .self) { row in
                    HStack {
                        ForEach(0..<4, id: \ .self) { column in
                            Rectangle()
                                .fill(
                                    matchedIndices.contains(where: { $0 == (row, column) }) ? Color.gray :
                                    (showAllSquares || revealedIndices.contains(where: { $0 == (row, column) })) ? colors[row][column] : Color.gray
                                )
                                .frame(width: 80, height: 80)
                                .onTapGesture {
                                    if !revealedIndices.contains(where: { $0 == (row, column) }),
                                       !matchedIndices.contains(where: { $0 == (row, column) }) {
                                        handleTap(row: row, column: column)
                                    }
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(selectedIndices.contains(where: { $0 == (row, column) }) ? Color.blue : Color.clear, lineWidth: 3)
                                )
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
            }
        }
        .padding()
        .navigationTitle("Medium Mode")
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
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer.invalidate()
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
                
                if matchedIndices.count == 16 {
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
        timeRemaining = 60
        revealTime = 3
        showAllSquares = true
        startInitialDelay()
    }
    
    private func generateGrid() -> [[Color]] {
        let allColors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple, .pink, .cyan]
        var colorPool = allColors.flatMap { [$0, $0] }
        colorPool.shuffle()
        
        var grid: [[Color]] = []
        for row in 0..<4 {
            var rowColors: [Color] = []
            for column in 0..<4 {
                rowColors.append(colorPool[row * 4 + column])
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
    MediumView()
}

