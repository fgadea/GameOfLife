//
//  main.swift
//  Game Of Life
//
//  Created by FELIPE GADEA LLOPIS on 2/10/24.
//

import Foundation

var actualState: [[ConwaysCell]] = []

var generationCount: Int = 0

let algorithm: ConwaysAlgorithm = ConwaysAlgorithm()
let gameInput: GameInput = GameInput()
let gameOutput: GameOutput = GameOutput()
let gameUtils: GameUtils = GameUtils()

// MARK: Get grid size
var gridSize: Int?
while gridSize == nil {
    gridSize = gameInput.requireGridSize()
    if gridSize == nil {
        print("\nThe input was wrong!! It must be an Integer. Try again!\n")
    }
}

// MARK: Get input option
var option: Int?
while option == nil {
    option = gameInput.requiereInputOption()
    if option == nil {
        print("\nThe input was wrong!! Try again!\n")
    }
}

// MARK: If input is 1
if option == 1 {
    for index in 1...gridSize! {
        var row: [ConwaysCell]?
        while row == nil {
            row = gameInput.requireRowInput(index: index, size: gridSize!)
            if row == nil {
                print("\nWrong input, try again!\n")
            }
        }
        gameInput.initialState.append(row!)
    }
}

// MARK: If input is 2
if option == 2 {
    gameInput.fillInitialState(gridSize)
    
    var pattern: Int?
    while pattern == nil {
        pattern = gameInput.requiereChoosePattern()
        if pattern == nil {
            print("\nThe input was wrong!! Try again!\n")
        }
    }
    
    if let pattern = Patterns(rawValue: pattern!) {
        print("You selected: \(pattern.getName())")
        gameInput.writePatternInGrid(pattern: pattern.getPattern())
    }
}

// MARK: Show input
print("Your grid is:")
gameOutput.printState(state: gameInput.initialState)

// MARK: Start the game
actualState = gameInput.initialState

while true {
    gameUtils.clearTerminal()
    gameOutput.printEpoch(epoch: actualState)
    gameUtils.wait(milliseconds: 100)
    actualState = gameOutput.nextState(state: actualState)
}


