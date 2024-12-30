//
//  InstrumentViewController.swift
//  MineSweeper
//
//  Created by 张翌璠 on 2021-02-10.
//

import UIKit

class InstructionViewController: UIViewController {

    @IBOutlet weak var instruction: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instruction.text = "This is a classic mine sweeper game.\n\nTo win the game, you need to open every single field without a bomb.\nYou lose once you step on a bomb(💣).\n\nThe number presented on each field shows how many bombs are around that field.\n\nSingle tap a field to open it.\nTry not to open any field with a bomb.\n\nLong tap a field to put a flag(🚩) on it if you think there is a bomb.\nTap a flag(🚩) to remove the flag.\n\nThe total number of bombs and a timer will be shown on top of all fields.\n\nEnjoy!🤪"
    }
}
