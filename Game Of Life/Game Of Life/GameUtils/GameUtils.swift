//
//  GameUtils.swift
//  Game Of Life
//
//  Created by MARIA EMPAR SALVADOR CALABUIG on 3/10/24.
//


class GameUtils {
    func wait(milliseconds: Int) {
        usleep(useconds_t(milliseconds * 1000))
    }
    
    func clearTerminal() {
        // Escape sequence to clear the screen
        print("\u{001B}[2J")
        // Move the cursor to the top-left corner
        print("\u{001B}[H")
    }
}