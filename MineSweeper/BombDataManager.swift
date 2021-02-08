//
//  BombDataManager.swift
//  MineSweeper
//
//  Created by 张翌璠 on 2021-02-07.
//

import Foundation
import UIKit
enum PlayStatus {
    case playing
    case win
    case lose
    case notStarted
    case started
}
protocol BombDataManagerDelegate {
    func openCell(index: Int)
    func win()
    func lose()
    func startPlaying()
    func newRound()
}
class BombDataManager {
    static let shared = BombDataManager()
    private init() {}
    var delegate: BombDataManagerDelegate?
    var isBomb = [Bool](repeating: false, count: 81)
    var bombNumber = [Int](repeating: 0, count: 81)
    var bombs = 0
    var dog = [Bool](repeating: false, count: 81)
    var opened = 0 {
        didSet {
            if opened == 1 {
                playStatus = .playing
            }
            else if opened == 81 - bombs {
                playStatus = .win
            }
        }
    }
    var playStatus: PlayStatus = .notStarted {
        didSet {
            switch playStatus {
            case .win:
                delegate?.win()
            case .lose:
                delegate?.lose()
            case .playing:
                delegate?.startPlaying()
            case .started:
                opened = 0
                delegate?.newRound()
            default:
                return
            }
        }
    }
    
    func configureData(first: Int) {
        refreshData()
        genetateBomb(first: first)
        for x in 0...80 {
            BombDataManager.shared.countBomb(bomb: BombDataManager.shared.isBomb[x], x: x)
        }
    }
    
    func refreshData() {
        isBomb = [Bool](repeating: false, count: 81)
        bombNumber = [Int](repeating: 0, count: 81)
        bombs = 0
        dog = [Bool](repeating: false, count: 81)
    }
    
    func genetateBomb(first: Int) {
        for index in 0...80 {
            let temp = Int(arc4random_uniform(4))
            if temp == 0 {
                isBomb[index] = true
            }
        }
        isBomb[first] = false
    }
    
    func countBomb(bomb: Bool, x: Int) {
        if bomb {
            bombs += 1
            if x % 9 != 0 && x % 9 != 8 && x >= 10 && x <= 70 {
                bombNumber[x] = 9;
                bombNumber[x+1] += 1;
                bombNumber[x-1] += 1;
                bombNumber[x-9] += 1;
                bombNumber[x+9] += 1;
                bombNumber[x-8] += 1;
                bombNumber[x+8] += 1;
                bombNumber[x-10] += 1;
                bombNumber[x+10] += 1;
            }
            else if x <= 8 && x % 9 != 0 && x % 9 != 8 && x >= 0 {
                bombNumber[x] = 9;
                bombNumber[x+1] += 1;
                bombNumber[x-1] += 1;
                bombNumber[x+9] += 1;
                bombNumber[x+10] += 1;
                bombNumber[x+8] += 1;
            }
            else if x == 0 {
                bombNumber[x] = 9;
                bombNumber[x+1] += 1;
                bombNumber[x+9] += 1;
                bombNumber[x+10] += 1;
            }
            else if x == 8 {
                bombNumber[x] = 9;
                bombNumber[x-1] += 1;
                bombNumber[x+8] += 1;
                bombNumber[x+9] += 1;
            }
            else if x == 80 {
                bombNumber[x] = 9;
                bombNumber[x-1] += 1;
                bombNumber[x-9] += 1;
                bombNumber[x-10] += 1;
            }
            else if x == 72 {
                bombNumber[x] = 9;
                bombNumber[x+1] += 1;
                bombNumber[x-8] += 1;
                bombNumber[x-9] += 1;
            }
            else if x % 9 == 0 {
                bombNumber[x] = 9;
                bombNumber[x+1] += 1;
                bombNumber[x-8] += 1;
                bombNumber[x-9] += 1;
                bombNumber[x+9] += 1;
                bombNumber[x+10] += 1;
            }
            else if x % 9 == 8 {
                bombNumber[x] = 9;
                bombNumber[x-1] += 1;
                bombNumber[x-9] += 1;
                bombNumber[x-10] += 1;
                bombNumber[x+9] += 1;
                bombNumber[x+8] += 1;
            }
            else {
                bombNumber[x] = 9;
                bombNumber[x-9] += 1;
                bombNumber[x-10] += 1;
                bombNumber[x-8] += 1;
                bombNumber[x+1] += 1;
                bombNumber[x-1] += 1;
            }
        }
    }
    
    func extend(num: Int) {
        if num >= 0 && num <= 80 {
            if opened == 0 {
                configureData(first: num)
            }
            delegate?.openCell(index: num)
            if bombNumber[num] == 0 {
                dog[num] = true
                if num % 9 != 0 && num % 9 != 8 && num >= 10 && num <= 70 {
                    if !dog[num + 1] {
                        extend(num: num + 1)
                    }
                    if !dog[num - 1] {
                        extend(num: num - 1)
                    }
                    if !dog[num - 9] {
                        extend(num: num - 9)
                    }
                    if !dog[num + 9] {
                        extend(num: num + 9)
                    }
                    if !dog[num - 8] {
                        extend(num: num - 8)
                    }
                    if !dog[num + 8] {
                        extend(num: num + 8)
                    }
                    if !dog[num - 10] {
                        extend(num: num - 10)
                    }
                    if !dog[num + 10] {
                        extend(num: num + 10)
                    }
                }
                else if num < 8 && num > 0 {
                    if !dog[num + 1] {
                        extend(num: num + 1)
                    }
                    if !dog[num - 1] {
                        extend(num: num - 1)
                    }
                    if !dog[num + 9] {
                        extend(num: num + 9)
                    }
                    if !dog[num + 10] {
                        extend(num: num + 10)
                    }
                    if !dog[num + 8] {
                        extend(num: num + 8)
                    }
                }
                else if num == 0 {
                    if !dog[1]{
                        extend(num: 1)
                    }
                    if !dog[9]{
                        extend(num: 9)
                    }
                    if !dog[10] {
                        extend(num: 10)
                    }
                }
                else if num == 8 {
                    if !dog[num + 8] {
                        extend(num: num + 8)
                    }
                    if !dog[num + 9] {
                        extend(num: num + 9)
                    }
                    if !dog[num - 1] {
                        extend(num: num - 1)
                    }
                }
                else if num == 80 {
                    if !dog[num - 1] {
                        extend(num: num - 1)
                    }
                    if !dog[num - 9] {
                        extend(num: num - 9)
                    }
                    if !dog[num - 10] {
                        extend(num: num - 10)
                    }
                }
                else if num == 72 {
                    if !dog[num + 1] {
                        extend(num: num + 1)
                    }
                    if !dog[num - 8] {
                        extend(num: num - 8)
                    }
                    if !dog[num - 9] {
                        extend(num: num - 9)
                    }
                }
                else if num % 9 == 0 {
                    if !dog[num + 1] {
                        extend(num: num + 1)
                    }
                    if !dog[num - 8] {
                        extend(num: num - 8)
                    }
                    if !dog[num - 9] {
                        extend(num: num - 9)
                    }
                    if !dog[num + 9] {
                        extend(num: num + 9)
                    }
                    if !dog[num + 10] {
                        extend(num: num + 10)
                    }
                }
                else if num % 9 == 8 {
                    if !dog[num - 1] {
                        extend(num: num - 1)
                    }
                    if !dog[num + 8] {
                        extend(num: num + 8)
                    }
                    if !dog[num - 10] {
                        extend(num: num - 10)
                    }
                    if !dog[num - 9] {
                        extend(num: num - 9)
                    }
                    if !dog[num + 9] {
                        extend(num: num + 9)
                    }
                }
                else {
                    if !dog[num - 8] {
                        extend(num: num - 8)
                    }
                    if !dog[num - 10] {
                        extend(num: num - 10)
                    }
                    if !dog[num + 1] {
                        extend(num: num + 1)
                    }
                    if !dog[num - 9] {
                        extend(num: num - 9)
                    }
                    if !dog[num - 1] {
                        extend(num: num - 1)
                    }
                }
            }
        }
    }
}
