//
//  GameOutput.swift
//  Game Of Life
//
//  Created by FELIPE GADEA LLOPIS on 3/10/24.
//

import Foundation

class GameOutput {
    func printState(state: [[ConwaysCell]]) {
        state.forEach { row in
            var rowToPrint: String = ""
            row.forEach {
                rowToPrint += $0.isAlive ? "1 " : "0 "
            }
            print(rowToPrint)
        }
    }
    
    func printEpoch(epoch: [[ConwaysCell]]) {
        epoch.forEach { _ in print(" -", terminator: "") }
        print("")
        epoch.forEach { row in
            var rowToPrint: String = ""
            print("|", terminator: "")
            row.forEach {
                rowToPrint += $0.isAlive ? "⏹ " : "  "
            }
            print(rowToPrint + "|")
        }
        epoch.forEach { _ in print(" -", terminator: "") }
        print("")
    }
    
    func getNeighbours(state: [[ConwaysCell]], column: Int, row: Int) -> [[ConwaysCell]] {
        var cellWithNeighbours: [[ConwaysCell]] = .init(
            repeating: .init(
                repeating: ConwaysCell(isAlive: false),
                count: 3
            ),
            count: 3
        )
        
        if column - 1 >= 0, row - 1 >= 0 { // Top Left
            cellWithNeighbours[0][0] = state[column - 1][row - 1]
        }
        
        if row - 1 >= 0 { // Top Center
            cellWithNeighbours[0][1] = state[column][row - 1]
        }
        
        if column + 1 < state.count, row - 1 >= 0 { // Top Right
            cellWithNeighbours[0][2] = state[column + 1][row - 1]
        }
        
        if column - 1 >= 0 { // Center Left
            cellWithNeighbours[1][0] = state[column - 1][row]
        }
        
        cellWithNeighbours[1][1] = state[column][row] // Center
        
        if column + 1 < state.count { // Center Right
            cellWithNeighbours[1][2] = state[column + 1][row]
        }
        
        if column - 1 >= 0, row + 1 < state[column].count { // Bottom Left
            cellWithNeighbours[2][0] = state[column - 1][row + 1]
        }
        
        if row + 1 < state[column].count { // Bottom Center
            cellWithNeighbours[2][1] = state[column][row + 1]
        }
        
        if column + 1 < state.count, row + 1 < state[column].count { // Bottom Right
            cellWithNeighbours[2][2] = state[column + 1][row + 1]
        }
        
        return cellWithNeighbours
    }
    
    func nextState(state: [[ConwaysCell]]) -> [[ConwaysCell]] {
        var futureState: [[ConwaysCell]] = .init(repeating: .init(repeating: ConwaysCell(isAlive: false), count: state.count), count: state.count)
        for column in 0..<state.count {
            for row in 0..<state[column].count {
                let cellWithNeighbors = getNeighbours(state: state, column: column, row: row)
                let nextStateOfCell = algorithm.evaluateCell(cells: cellWithNeighbors)
                futureState[column][row] = nextStateOfCell
            }
        }
        return futureState
    }
}
