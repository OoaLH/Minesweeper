//
//  InfoViewController.swift
//  minesweep
//
//  Created by Yi Fan Zhang on 26/01/2018.
//  Copyright © 2018 Yi Fan Zhang. All rights reserved.
//

import UIKit
import CoreData
class InfoViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let fetchRequest = NSFetchRequest<Time>(entityName: "Time")
    override func viewDidLoad() {
        super.viewDidLoad()
        generatedata()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var main: UIScrollView!
    func generatedata(){
        let context = appDelegate.persistentContainer.viewContext
        main.isScrollEnabled = true // 可以上下滚动
        main.scrollsToTop = true // 点击状态栏时，可以滚动回顶端
        main.bounces = true // 反弹效果，即在最顶端或最底端时，仍然可以滚动，且释放后有动画返回效果
        main.showsVerticalScrollIndicator = true // 显示垂直滚动条
        main.showsHorizontalScrollIndicator = false
        main.delegate = self as? UIScrollViewDelegate
        main.isDirectionalLockEnabled = true
      
        var rank=1
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
          // var originY:CGFloat = 10.0
            for info in fetchedObjects{
                let label = UILabel()
                label.frame=CGRect(x: 87, y: (rank-1)*40, width: 200, height: 40)
                rank+=1
                if info.seconds>=10{
                label.text=String(info.minutes)+":"+String(info.seconds)+"                             "+String(info.bombnum)
                }
                else{
                    label.text=String(info.minutes)+":"+"0"+String(info.seconds)+"                             "+String(info.bombnum)
                }
                label.textColor=UIColor.blue
                label.isUserInteractionEnabled = true
                main.addSubview(label)
              
            }
              main.contentSize = CGSize(width:main.frame.size.width,height:CGFloat((rank-1)*40))
        }
        catch {
            fatalError("\(error)")
        }
    }
    func clearview() {
        for v in self.view.subviews as [UIView] {
            for index in 1..<82{
                v.viewWithTag(index)?.removeFromSuperview()
            }}
    }
    @IBAction func onBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func clearrecords(_ sender: UIButton) {
        let context = appDelegate.persistentContainer.viewContext
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            
            
            for info in fetchedObjects{
                context.delete(info)
            }
            try! context.save()
        }
        catch {
            fatalError("\(error)")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
