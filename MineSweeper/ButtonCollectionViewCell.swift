//
//  buttonCollectionViewCell.swift
//  MineSweeper
//
//  Created by 张翌璠 on 2021-02-07.
//

import Foundation
import UIKit
enum CellState {
    case opened(Int)
    case closed
    case flaged
}
class ButtonCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var button: UIButton!
    var index: Int = 0
    var status: CellState = .closed {
        didSet {
            switch status {
            case .closed:
                button.setTitle("", for: .normal)
                button.backgroundColor = UIColor.systemBlue
            case .flaged:
                button.setTitle("🚩", for: .normal)
                button.backgroundColor = UIColor.systemBlue
            case .opened(let num):
                if num >= 9 {
                    button.setTitle("💣", for: .normal)
                    button.backgroundColor = UIColor.red
                    BombDataManager.shared.playStatus = .lose
                }
                else if num == 0 {
                    BombDataManager.shared.opened += 1
                    button.setTitle("", for: .normal)
                    button.backgroundColor = UIColor.white
                }
                else {
                    BombDataManager.shared.opened += 1
                    button.setTitle(String(num), for: .normal)
                    button.backgroundColor = UIColor.white
                }
                print(BombDataManager.shared.opened)
                print(BombDataManager.shared.bombs)
            }
        }
    }
    
    @IBAction func mine(_ sender: UIButton) {
        switch BombDataManager.shared.playStatus {
        case .playing:
            switch status {
            case .flaged:
                status = .closed
            case .closed:
                BombDataManager.shared.extend(num: index)
            default:
                return
            }
        default:
            return
        }
    }
}
