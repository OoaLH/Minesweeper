//
//  BombCellDataModel.swift
//  MineSweeper
//
//  Created by Yi Fan Zhang on 2024/12/30.
//

enum CellState: Equatable {
    
    case revealed
    case unrevealed
    case flaged
}

class BombCellDataModel {
    
    let row: Int
    let column: Int
    let index: Int
    
    var state: CellState = .unrevealed {
        didSet {
            stateDidChange?()
        }
    }
    
    var numberOfBombs: Int = 0
    
    var stateDidChange: (() -> Void)?
    
    var hasBomb: Bool {
        numberOfBombs >= 9
    }
    
    init(row: Int, column: Int, index: Int) {
        self.row = row
        self.column = column
        self.index = index
    }
}
