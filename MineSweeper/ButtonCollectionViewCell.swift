//
//  buttonCollectionViewCell.swift
//  MineSweeper
//
//  Created by 张翌璠 on 2021-02-07.
//

import Foundation
import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var button: UIButton!
    
    var model: BombCellDataModel? {
        didSet {
            model?.stateDidChange = { [weak self] in
                self?.stateDidChange()
            }
        }
    }
    
    override func didMoveToSuperview() {
        button.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(flag)))
        button.layer.cornerRadius = 2
    }
    
    
    private func stateDidChange() {
        guard let state = model?.state,
              let num = model?.numberOfBombs else {
            return
        }
        switch state {
        case .unrevealed:
            button.setTitle("", for: .normal)
            button.backgroundColor = UIColor.systemOrange
        case .flaged:
            button.setTitle("🚩", for: .normal)
            button.backgroundColor = UIColor.systemOrange
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        case .revealed:
            if num >= 9 {
                button.setTitle("💣", for: .normal)
                button.backgroundColor = UIColor.red
                GameManager.shared.gameStatus = .lost
            }
            else if num == 0 {
                GameManager.shared.numberOfRevealed += 1
                button.setTitle("", for: .normal)
                button.backgroundColor = UIColor.white
            }
            else {
                GameManager.shared.numberOfRevealed += 1
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
    
    @IBAction func mine(_ sender: UIButton) {
        guard let model else {
            return
        }
        
        switch GameManager.shared.gameStatus {
        case .started,
                .playing:
            switch model.state {
            case .flaged:
                model.state = .unrevealed
            case .unrevealed:
                GameManager.shared.unreveal(model: model)
            case .revealed:
                return
            }
        case .won,
                .lost:
            return
        }
    }
    
    @objc func flag() {
        guard let model else {
            return
        }
        
        switch GameManager.shared.gameStatus {
        case .started,
                .playing:
            switch model.state {
            case .unrevealed:
                model.state = .flaged
            case .flaged, .revealed:
                return
            }
        case .won,
                .lost:
            return
        }
    }
}
