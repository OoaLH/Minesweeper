//
//  ViewController.swift
//  MineSweeper
//
//  Created by 张翌璠 on 2021-02-07.
//

import UIKit

class ViewController: UIViewController {
    var timer: Timer?
    var time: TimeInterval = 0 {
        didSet {
            var second = String(Int(time)%60)
            if Int(time)%60 < 10 {
                second = "0" + second
            }
            timeLabel.text = String(Int(time/60)) + ":" + second
        }
    }
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var buttonCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        BombDataManager.shared.delegate = self
    }
    
    @IBAction func newRound(_ sender: UIButton) {
        time = 0
        timer?.invalidate()
        for i in buttonCollectionView.visibleCells {
            let cell = i as! ButtonCollectionViewCell
            cell.status = .closed
        }
        BombDataManager.shared.playStatus = .started
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 81
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleButton", for: indexPath) as! ButtonCollectionViewCell
        cell.index = indexPath.item
        cell.configureButton()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 48)/9, height: (UIScreen.main.bounds.width - 48)/9)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

extension ViewController: BombDataManagerDelegate {
    func win() {
        statusLabel.text = "You win!"
        timer?.invalidate()
    }
    
    func lose() {
        statusLabel.text = "You lose!"
        timer?.invalidate()
    }
    
    func startPlaying() {
        statusLabel.text = "Number of bombs: " + String(BombDataManager.shared.bombs)
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {[weak self] (timer) in
            self?.time += 1
        })
    }
    
    func openCell(index: Int) {
        let cell = buttonCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as! ButtonCollectionViewCell
        switch cell.status {
        case .opened(_):
            break
        default:
            cell.status = .opened(BombDataManager.shared.bombNumber[index])
        }
    }
    
    func newRound() {
        statusLabel.text = "Started!"
    }
}
