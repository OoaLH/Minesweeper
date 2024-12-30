//
//  BombDataManager.swift
//  MineSweeper
//
//  Created by 张翌璠 on 2021-02-07.
//

import Foundation
import UIKit

enum GameStatus {
    
    case playing
    case won
    case lost
    case started
}

protocol BombDataManagerDelegate: AnyObject {
    
    func didWin()
    func didLose()
    func didStartPlaying()
    func didStartNewRound()
}

class GameManager {
    
    static let shared = GameManager()
    
    private init() {
        var index = 0
        var models: [[BombCellDataModel]] = []
        var flattenedModels: [BombCellDataModel] = []
        
        for row in 0..<9 {
            var rowData: [BombCellDataModel] = []
            for column in 0..<9 {
                let model = BombCellDataModel(row: row, column: column, index: index)
                rowData.append(model)
                flattenedModels.append(model)
                index += 1
            }
            models.append(rowData)
        }
        
        bombCellDataModels = models
        flattenedBombCellDataModels = flattenedModels
    }
    
    weak var delegate: BombDataManagerDelegate?
    
    let bombCellDataModels: [[BombCellDataModel]]
    let flattenedBombCellDataModels: [BombCellDataModel]
    
    var numberOfBombs = 0
    var numberOfRevealed = 0 {
        didSet {
            if numberOfRevealed == 1 {
                gameStatus = .playing
            } else if numberOfRevealed == 81 - numberOfBombs {
                gameStatus = .won
            }
        }
    }
    
    var gameStatus: GameStatus = .started {
        didSet {
            switch gameStatus {
            case .won:
                delegate?.didWin()
            case .lost:
                delegate?.didLose()
            case .playing:
                delegate?.didStartPlaying()
            case .started:
                newRound()
            }
        }
    }
    
    private func newRound() {
        numberOfRevealed = 0
        numberOfBombs = 0
        
        flattenedBombCellDataModels.forEach { model in
            model.numberOfBombs = 0
            model.state = .unrevealed
        }
        
        delegate?.didStartNewRound()
    }
    
    private func initiateBombs(row: Int, column: Int) {
        generateBombs(row: row, column: column)
        countBombs()
    }
    
    private func generateBombs(row: Int, column: Int) {
        for row in 0..<9 {
            for column in 0..<9 {
                let temp = Int(arc4random_uniform(4))
                if temp == 0 {
                    bombCellDataModels[row][column].numberOfBombs = 9
                }
            }
        }
        bombCellDataModels[row][column].numberOfBombs = 0
    }
    
    private func countBombs() {
        for row in 0..<9 {
            for column in 0..<9 {
                if bombCellDataModels[row][column].hasBomb {
                    numberOfBombs += 1
                    
                    for newRow in [row - 1, row, row + 1] {
                        for newColumn in [column - 1, column, column + 1] {
                            if newRow != row || newColumn != column {
                                bombCellDataModels[safe: newRow]?[safe: newColumn]?.numberOfBombs += 1
                            }
                        }
                    }
                }
            }
        }
    }
    
    func unreveal(model: BombCellDataModel) {
        if numberOfRevealed == 0 {
            initiateBombs(row: model.row, column: model.column)
        }
        
        model.state = .revealed
        
        if model.numberOfBombs == 0 {
            for row in [model.row - 1, model.row, model.row + 1] {
                for column in [model.column - 1, model.column, model.column + 1] {
                    if let newModel = bombCellDataModels[safe: row]?[safe: column],
                       newModel.state == .unrevealed {
                        unreveal(model: newModel)
                    }
                }
            }
        }
    }
}

extension Collection {
    // Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
