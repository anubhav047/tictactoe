import SwiftUI

struct ContentView: View {
    // The game board represented as a 2D array
    @State private var board: [[String]] = Array(
        repeating: Array(repeating: "", count: 3),
        count: 3
    )
    
    // Tracks the current player ("X" or "O")
    @State private var currentPlayer = "X"
    
    // Indicates whether the game is over
    @State private var gameOver = false
    
    // Stores the winner ("X", "O", or "Draw")
    @State private var winner: String?
    
    var body: some View {
        VStack {
            Text("Tic Tac Toe")
                .font(.largeTitle)
                .padding()
            
            Text("Player \(currentPlayer)'s Turn")
                .font(.title2)
                .padding(.bottom, 20)
            
            // The game grid
            ForEach(0..<3) { row in
                HStack {
                    ForEach(0..<3) { column in
                        Button(action: {
                            handleTap(row: row, column: column)
                        }) {
                            Text(board[row][column])
                                .font(.system(size: 60))
                                .frame(width: 80, height: 80)
                                .foregroundColor(.black)
                                .background(Color.gray.opacity(0.2))
                                .border(Color.black, width: 1)
                        }
                        .disabled(board[row][column] != "" || gameOver)
                    }
                }
            }
            
            // Display the result when the game is over
            if gameOver {
                VStack {
                    if let winner = winner {
                        Text(winner == "Draw" ? "It's a Draw!" : "Player \(winner) Wins!")
                            .font(.title)
                            .padding()
                    }
                    Button("Play Again") {
                        resetGame()
                    }
                    .padding()
                }
            }
            Spacer()
        }
        .padding()
    }
    
    // Handles the player's tap action
    func handleTap(row: Int, column: Int) {
        if board[row][column] == "" {
            board[row][column] = currentPlayer
            if checkWin(for: currentPlayer) {
                winner = currentPlayer
                gameOver = true
            } else if checkDraw() {
                winner = "Draw"
                gameOver = true
            } else {
                // Switch to the next player
                currentPlayer = currentPlayer == "X" ? "O" : "X"
            }
        }
    }
    
    // Checks if the specified player has won
    func checkWin(for player: String) -> Bool {
        // Check rows
        for row in 0..<3 {
            if board[row][0] == player &&
               board[row][1] == player &&
               board[row][2] == player {
                return true
            }
        }
        // Check columns
        for column in 0..<3 {
            if board[0][column] == player &&
               board[1][column] == player &&
               board[2][column] == player {
                return true
            }
        }
        // Check diagonals
        if board[0][0] == player &&
           board[1][1] == player &&
           board[2][2] == player {
            return true
        }
        if board[0][2] == player &&
           board[1][1] == player &&
           board[2][0] == player {
            return true
        }
        return false
    }
    
    // Checks if the game is a draw
    func checkDraw() -> Bool {
        for row in board {
            if row.contains("") {
                return false
            }
        }
        return true
    }
    
    // Resets the game state for a new game
    func resetGame() {
        board = Array(
            repeating: Array(repeating: "", count: 3),
            count: 3
        )
        currentPlayer = "X"
        gameOver = false
        winner = nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
