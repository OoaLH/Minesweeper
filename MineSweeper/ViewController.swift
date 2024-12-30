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
            var second = String(Int(time) % 60)
            if Int(time) % 60 < 10 {
                second = "0" + second
            }
            timeLabel.text = String(Int(time / 60)) + ":" + second
        }
    }
    
    @IBOutlet weak var newRoundButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var buttonCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        GameManager.shared.delegate = self
        GameManager.shared.gameStatus = .started
    }
    
    func configureViews() {
        newRoundButton.layer.cornerRadius = newRoundButton.frame.height/2
    }
    
    @IBAction func newRound(_ sender: UIButton) {
        time = 0
        timer?.invalidate()
        
        GameManager.shared.gameStatus = .started
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GameManager.shared.flattenedBombCellDataModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleButton", for: indexPath) as! ButtonCollectionViewCell
        cell.model = GameManager.shared.flattenedBombCellDataModels[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 8) / 9
        let height = (collectionView.frame.height - 8) / 9
        return CGSize(width: width, height: height)
    }
}

extension ViewController: BombDataManagerDelegate {
    
    func didWin() {
        statusLabel.text = "You win!"
        timer?.invalidate()
    }
    
    func didLose() {
        statusLabel.text = "You lose!"
        timer?.invalidate()
    }
    
    func didStartPlaying() {
        statusLabel.text = "Number of bombs: " + String(GameManager.shared.numberOfBombs)
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {[weak self] (timer) in
            self?.time += 1
        })
    }
    
    func didStartNewRound() {
        statusLabel.text = "Started!"
    }
}
