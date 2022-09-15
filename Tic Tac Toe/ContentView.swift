//
//  ContentView.swift
//  Tic Toe
//
//  Created by Blair Hall on 9/14/22.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = ["", "", "", "", "", "", "", "", ""]
    @State private var endGameText = "TicTacToe"
    @State private var gameEnded = false
    private var ranges: [Range<Int>] = [(0..<3), (3..<6), (6..<9)]
    var body: some View {
        VStack {
            Text(endGameText)
            /*Button("Reset") {
                gameEnded = true
                resetGame()
            }
                .alert(isPresented: $gameEnded, content: {
                    Alert(
                        title: Text(endGameText)
                    )
                })*/
            Spacer()
            
            ForEach(ranges, id: \.self) { range in
                HStack {
                    ForEach(range, id: \.self) { i in
                        XOButton(letter: $moves[i])
                            .simultaneousGesture(
                                TapGesture()
                                    .onEnded { _ in
                                        playerTap(index: i)
                                    }
                            )
                    }
                }
            }
            Spacer()
            Button("Reset") {
                gameEnded = true
                resetGame()
            }
                .alert(isPresented: $gameEnded, content: {
                    Alert(
                        title: Text(endGameText)
                    )
                })
            //Button("Reset", action: resetGame)
        }
    }
    func playerTap(index: Int) {
        if moves[index] == "" {
            moves[index] = "X"
            botMove()
        }
        
        for letter in ["X", "0"] {
            if checkWinner(list: moves, letter: letter) {
            endGameText = "\(letter) has won!"
            gameEnded = true
            break
            }
        }
    }
    func botMove() {
        var availableMoves: [Int] = []
        var movesLeft = 0
            
        for move in moves {
            if move == "" {
                availableMoves.append(movesLeft)
            }
            movesLeft += 1
        }
            if availableMoves.count != 0 {
                moves[availableMoves.randomElement()!] = "0"
            }
        }
    
    func resetGame() {
        endGameText = "Game Reset"
        moves = ["", "", "", "", "", "", "", "", ""]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
            ContentView()
            ContentView()
            ContentView()
        }
    }
}
