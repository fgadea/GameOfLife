//
//  ConwaysAlgorithm.swift
//  Game Of Life
//
//  Created by FELIPE GADEA LLOPIS on 3/10/24.
//


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
                if column == 1, row == 1 { continue }
                roundingCells.append(cells[row][column])
            }
        }
        return roundingCells
    }

    private func getAliveCells(cells: [ConwaysCell]) -> Int {
        return cells.filter(\.isAlive).count
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
