//
//  main.swift
//  Game Of Life
//
//  Created by FELIPE GADEA LLOPIS on 2/10/24.
//

import Foundation

struct ConwaysCell {
    var isAlive: Bool
}

var actualState: [[ConwaysCell]] = []
var futureState: [[ConwaysCell]] = []

var generationCount: Int = 0

class ConwaysAlgorithm {
    func evaluateCell(cells: [[ConwaysCell]]) -> ConwaysCell {
        let surroundingCells = getSurroundingCells(cells: cells)
        let aliveCells = getAliveCells(cells: surroundingCells)
        return .init(isAlive: nextState(aliveCells: aliveCells, cell: cells[1][1]))
    }
    
    private func getSurroundingCells(cells: [[ConwaysCell]]) -> [ConwaysCell] {
        guard cells.count == 3 else { return [] }
        guard cells.first?.count == 3 else { return [] }
        var roundingCells: [ConwaysCell] = []
        for column in 0..<3 {
            for row in 0..<3 {
                guard column != 1, row != 1 else { continue }
                roundingCells.append(cells[row][column])
            }
        }
        return roundingCells
    }

    private func getAliveCells(cells: [ConwaysCell]) -> Int {
        cells.filter(\.isAlive).count
    }

    private func nextState(aliveCells: Int, cell: ConwaysCell) -> Bool {
        if cell.isAlive {
            if aliveCells < 2 || aliveCells > 3 {
                return false // Overpopulation or Underpopulation
            } else {
                return true // Survives
            }
        }
        if aliveCells == 3 {
            return true // Dead cell with exactly three live neighbours
        }
        
        return false
    }
}

func requireGridSize() -> Int? {
    print("Please, especify the size of the grid for the game. It will be square, so only the length of one side is needed. Which size would you like?")
    let size: String? = readLine(strippingNewline: true)
    if let size, let intSize = Int(size), intSize < 100 {
        return intSize
    }
    return nil
}

var gridSize: Int?

while gridSize == nil {
    gridSize = requireGridSize()
    if gridSize == nil {
        print("\nThe input was wrong!! It must be an Integer. Try again!\n")
    }
}

func requiereInputOption() -> Int? {
    print("Please, choose one of the two options:")
    print("1. Manual input")
    print("2. Select a pattern")
    let option: String? = readLine(strippingNewline: true)
    if let option, let intOption = Int(option), intOption < 3 {
        return intOption
    }
    return nil
}

var option: Int?

while option == nil {
    option = requiereInputOption()
    if option == nil {
        print("\nThe input was wrong!! Try again!\n")
    }
}

func requireRowInput(index: Int, size: Int) -> [ConwaysCell]? {
    print("Please, enter the row \(index) indicating 0 for dead and 1 for alive cells separated by spaces:")
    let row: String? = readLine(strippingNewline: true)
    guard let row else { return nil }
    guard row.components(separatedBy: " ").count == size else { return nil }
    let rowSeparated = row.components(separatedBy: " ")
    let intRow = rowSeparated.compactMap({Int($0)})
    guard intRow.count == size else { return nil }
    guard intRow.allSatisfy({$0 == 0 || $0 == 1}) else { return nil }
    
    return intRow.map { ConwaysCell(isAlive: $0 == 1) }
}

var initialGrid: [[ConwaysCell]] = []
for index in 1...gridSize! {
    var row: [ConwaysCell]?
    while row == nil {
        row = requireRowInput(index: index, size: gridSize!)
        if row == nil {
            print("Wrong input, try again!")
        }
    }
    initialGrid.append(row!)
    
}

print("Your grid is:")
initialGrid.forEach { row in
    var rowToPrint: String = ""
    row.forEach {
        rowToPrint += $0.isAlive ? "1 " : "0 "
    }
    print(rowToPrint)
}

