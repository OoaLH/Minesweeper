//
//  ViewController.swift
//  MineSweeper
//
//  Created by 张翌璠 on 2021-02-07.
//

import GoogleMobileAds
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
    @IBOutlet weak var newRoundButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var buttonCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        BombDataManager.shared.delegate = self
        bannerView.load(GADRequest())
    }
    
    func configureViews() {
        newRoundButton.layer.cornerRadius = newRoundButton.frame.height/2
        
        view.addSubview(bannerView)
        NSLayoutConstraint.activate([
            bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bannerView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
    }
    
    lazy var bannerView: GADBannerView = {
        let view = GADBannerView(adSize: kGADAdSizeBanner)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        view.rootViewController = self
        view.delegate = self
        return view
    }()
    
    @IBAction func newRound(_ sender: UIButton) {
        time = 0
        timer?.invalidate()
        for i in buttonCollectionView.visibleCells {
            let cell = i as! ButtonCollectionViewCell
            cell.status = .closed
        }
        BombDataManager.shared.playStatus = .started
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ViewController: GADBannerViewDelegate {
//    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
//      print("bannerViewDidReceiveAd")
//    }
//
//    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
//      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
//    }
//
//    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
//      print("bannerViewDidRecordImpression")
//    }
//
//    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
//      print("bannerViewWillPresentScreen")
//    }
//
//    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
//      print("bannerViewWillDIsmissScreen")
//    }
//
//    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
//      print("bannerViewDidDismissScreen")
//    }
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
        case .closed:
            cell.status = .opened(BombDataManager.shared.bombNumber[index])
        default:
            return
        }
    }
    
    func newRound() {
        statusLabel.text = "Started!"
    }
}
