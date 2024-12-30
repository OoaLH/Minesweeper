//
//  HomeViewController.swift
//  MineSweeper
//
//  Created by 张翌璠 on 2021-02-10.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var instrumentButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    func configureViews() {
        startButton.layer.cornerRadius = startButton.frame.height/2
        instrumentButton.layer.cornerRadius = instrumentButton.frame.height/2
        aboutButton.layer.cornerRadius = aboutButton.frame.height/2
    }
    
    @IBAction func aboutMe(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://github.com/OoaLH")!)
    }
}
