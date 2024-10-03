//
//  GameInput.swift
//  Game Of Life
//
//  Created by FELIPE GADEA LLOPIS on 3/10/24.
//

class GameInput {
    var initialState: [[ConwaysCell]] = []
    func requireGridSize() -> Int? {
        print("Please, especify the size of the grid for the game. It will be square, so only the length of one side is needed. Which size would you like (must be between 38 and 100)?")
        let size: String? = readLine(strippingNewline: true)
        if let size, let intSize = Int(size), intSize <= 100, intSize >= 38 {
            return intSize
        }
        return nil
    }
    
    func requiereInputOption() -> Int? {
        print("Please, choose one of the two options:")
        print("1. Manual input")
        print("2. Select a pattern")
        let option: String? = readLine(strippingNewline: true)
        if let option, let intOption = Int(option), intOption < 3, intOption > 0 {
            return intOption
        }
        return nil
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
    
    func requiereChoosePattern() -> Int? {
        print("Please, choose one of the two options:")
        print("1. Block")
        print("2. Beehive")
        print("3. Loaf")
        print("4. Boat")
        print("5. Tub")
        print("6. Blinker")
        print("7. Toad")
        print("8. Beacon")
        print("9. Glider")
        print("10. Gosper glider gun")
        let option: String? = readLine(strippingNewline: true)
        if let option, let intOption = Int(option), intOption < 11, intOption > 0 {
            return intOption
        }
        return nil
    }
    
    func writePatternInGrid(pattern: [[ConwaysCell]]) {
        let patternRadius = pattern.count / 2
        let gridCenter = initialState.count / 2
        let startPoint = gridCenter - patternRadius
        let finishPont = gridCenter + patternRadius
        for colum in zip(startPoint...finishPont, 0..<pattern.count) {
            for row in zip(startPoint...finishPont, 0..<pattern.count) {
                initialState[colum.0][row.0] = pattern[colum.1][row.1]
            }
        }
    }
    
    func fillInitialState(_ gridSize: Int?) {
        guard let gridSize else { return }
        for _ in 0..<gridSize {
            initialState.append(.init(repeating: ConwaysCell(isAlive: false), count: gridSize))
        }
    }
}
