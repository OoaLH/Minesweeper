//
//  buttonCollectionViewCell.swift
//  MineSweeper
//
//  Created by 张翌璠 on 2021-02-07.
//

import Foundation
import UIKit

enum CellState: Equatable {
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
                button.backgroundColor = UIColor.systemOrange
            case .flaged:
                button.setTitle("🚩", for: .normal)
                button.backgroundColor = UIColor.systemOrange
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
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
                    switch num {
                    case 1:
                        button.setTitleColor(UIColor.systemBlue, for: .normal)
                    case 2:
                        button.setTitleColor(UIColor.systemGreen, for: .normal)
                    case 3:
                        button.setTitleColor(UIColor.systemRed, for: .normal)
                    case 4:
                        button.setTitleColor(UIColor.systemYellow, for: .normal)
                    case 5:
                        button.setTitleColor(UIColor.systemOrange, for: .normal)
                    case 6:
                        button.setTitleColor(UIColor.systemTeal, for: .normal)
                    case 7:
                        button.setTitleColor(UIColor.black, for: .normal)
                    case 8:
                        button.setTitleColor(UIColor.systemGray, for: .normal)
                    default:
                        return
                    }
                }
            }
        }
    }
    
    func configureButton() {
        button.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(flag)))
        button.layer.cornerRadius = 2
    }
    
    @IBAction func mine(_ sender: UIButton) {
        switch BombDataManager.shared.playStatus {
        case .started, .playing:
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
    
    @objc func flag() {
        if (BombDataManager.shared.playStatus == .playing || BombDataManager.shared.playStatus == .started) && status == .closed {
            status = .flaged
        }
    }
}
