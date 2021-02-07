//
//  ViewController.swift
//  minesweep
//
//  Created by Yi Fan Zhang on 15/09/2017.
//  Copyright © 2017 Yi Fan Zhang. All rights reserved.
//

import UIKit
import CoreData
var ifthereisabomb = [Int](repeating: 0, count: 81)
var bombnumber = [Int](repeating: 0, count: 81)
var dog = [Int](repeating: 0, count: 81)
var bombs = 0
var colorchange = [Int](repeating: 0, count: 81)
var openednumber = 0
var opened = [Int](repeating: 0, count: 81)
func generatebomb()
{
    
    for x in 0...80
    {
        ifthereisabomb[x] = Int(arc4random_uniform(4))
    }
}
func countbomb(bomb: Int,x: Int)
{
    
    
    if bomb == 1{
        bombs+=1
        if x%9 != 0 && x%9 != 8 && x>=10&&x<=70
        {
            bombnumber[x]=9;
            bombnumber[x+1] += 1;
            bombnumber[x-1] += 1;
            bombnumber[x-9] += 1;
            bombnumber[x+9] += 1;
            bombnumber[x-8] += 1;
            bombnumber[x+8] += 1;
            bombnumber[x-10] += 1;
            bombnumber[x+10] += 1;
        }
        else if x<=8&&x%9 != 0&&x%9 != 8&&x>=0
        {
            bombnumber[x]=9;
            bombnumber[x+1] += 1;
            bombnumber[x-1] += 1;
            bombnumber[x+9] += 1;
            bombnumber[x+10] += 1;
            bombnumber[x+8] += 1;
        }
        else if x==0
        {
            bombnumber[x]=9;
            bombnumber[x+1] += 1;
            bombnumber[x+9] += 1;
            bombnumber[x+10] += 1;
        }
        else if x==8
        {
            bombnumber[x]=9;
            bombnumber[x-1] += 1;
            bombnumber[x+8] += 1;
            bombnumber[x+9] += 1;
        }
        else if x==80
        {
            bombnumber[x]=9;
            bombnumber[x-1] += 1;
            bombnumber[x-9] += 1;
            bombnumber[x-10] += 1;
        }
        else if x==72
        {
            bombnumber[x]=9;
            bombnumber[x+1] += 1;
            bombnumber[x-8] += 1;
            bombnumber[x-9] += 1;
        }
        else if x%9==0
        {
            bombnumber[x]=9;
            bombnumber[x+1] += 1;
            bombnumber[x-8] += 1;
            bombnumber[x-9] += 1;
            bombnumber[x+9] += 1;
            bombnumber[x+10] += 1;
        }
        else if x%9==8
        {
            bombnumber[x]=9;
            bombnumber[x-1] += 1;
            bombnumber[x-9] += 1;
            bombnumber[x-10] += 1;
            bombnumber[x+9] += 1;
            bombnumber[x+8] += 1;
        }
        else
        {
            bombnumber[x]=9;
            bombnumber[x-9] += 1;
            bombnumber[x-10] += 1;
            bombnumber[x-8] += 1;
            bombnumber[x+1] += 1;
            bombnumber[x-1] += 1;
        }
        
    }
}
func extend(num: Int)
{
    
    if num>=0&&num<=80{
        if bombnumber[num]>0&&bombnumber[num]<9
        {
            
            
            colorchange[num] = 1
        }
        else if bombnumber[num]==0
        {
            
            
            colorchange[num] = 1
            dog[num]=1
            if num%9 != 0&&num%9 != 8&&num>=10&&num<=70
            {
                if(dog[num+1] != 1)
                {
                    extend(num: num+1)
                }
                if(dog[num-1] != 1){
                    extend(num: num-1)
                }
                if(dog[num-9] != 1){
                    extend(num: num-9)
                }
                if(dog[num+9] != 1){
                    extend(num: num+9)}
                if(dog[num-8] != 1){
                    extend(num: num-8)}
                if(dog[num+8] != 1){
                    extend(num: num+8)}
                if(dog[num-10] != 1){
                    extend(num: num-10)}
                if(dog[num+10] != 1){
                    extend(num: num+10)}
            }
            else if(num<=8&&num%9 != 0&&num%9 != 8&&num>=0)
            {
                if(dog[num+1] != 1){
                    extend(num: num+1)}
                if(dog[num-1] != 1){
                    extend(num: num-1)}
                if(dog[num+9] != 1){
                    extend(num: num+9)}
                if(dog[num+10] != 1){
                    extend(num: num+10)}
                if(dog[num+8] != 1){
                    extend(num: num+8)}
            }
            else if(num==0)
            {
                if(dog[1] != 1){
                    extend(num: 1)}
                if(dog[9] != 1){
                    extend(num: 9)}
                if(dog[10] != 1){
                    extend(num: 10)}
            }
            else if(num==8)
            {
                if(dog[num+8] != 1){
                    extend(num: num+8)}
                
                if(dog[num+9] != 1){
                    extend(num: num+9)}
                if(dog[num-1] != 1){
                    extend(num: num-1)}
            }
            else if(num==80)
            {
                if(dog[num-1] != 1){
                    extend(num: num-1)}
                if(dog[num-9] != 1){
                    extend(num: num-9)}
                if(dog[num-10] != 1){
                    extend(num: num-10)}
                
            }
            else if(num==72)
            {
                if(dog[num+1] != 1){
                    extend(num: num+1)}
                if(dog[num-8] != 1){
                    extend(num: num-8)}
                if(dog[num-9] != 1){
                    extend(num: num-9)}
                
            }
            else if(num%9==0)
            {
                if(dog[num+1] != 1){
                    extend(num: num+1)}
                if(dog[num-8] != 1){
                    extend(num: num-8)}
                if(dog[num-9] != 1){
                    extend(num: num-9)}
                if(dog[num+9] != 1){
                    extend(num: num+9)}
                if(dog[num+10] != 1){
                    extend(num: num+10)}
                
            }
            else if(num%9==8)
            {
                if(dog[num-1] != 1){
                    extend(num: num-1)}
                if(dog[num+8] != 1){
                    extend(num: num+8)}
                if(dog[num-10] != 1){
                    extend(num: num-10)}
                if(dog[num-9] != 1){
                    extend(num: num-9)}
                if(dog[num+9] != 1){
                    extend(num: num+9)}
            }
            else
            {
                if(dog[num-8] != 1){
                    extend(num: num-8)}
                if(dog[num-10] != 1){
                    extend(num: num-10)}
                
                if(dog[num+1] != 1){
                    extend(num: num+1)}
                if(dog[num-9] != 1){
                    extend(num: num-9)}
                if(dog[num-1] != 1){
                    extend(num: num-1)}
            }
        }
    }
    
}


class ViewController: UIViewController {
    var playing = false
    var first = false
    var timer = Timer()
    
    var seconds = 0
    var minutes = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        generateview()
        
        timing.text="time:0:00"
        countbombs.text=" "
        end.text = "start!"
        bombnumber = [Int](repeating: 0, count: 81)
        bombs = 0
        openednumber = 0
        opened = [Int](repeating: 0, count: 81)
        colorchange = [Int](repeating: 0, count: 81)
        generatebomb()
        dog = [Int](repeating: 0, count: 81)
        seconds = 0
        minutes = 0
        
        first = true
    }
    
    @objc func long(sender:UIGestureRecognizer)
    {
        if sender.state == .began{
            longpress(num:sender.view!.tag)
            
        }
    }
    func longpress(num:Int)
    {
        if opened[num-1]==0{
            let flag = UIButton(type:.system)
            flag.frame=CGRect(x: 7+((num-1)%9)*40, y: 135+((num-1)/9-1)*40, width: 40, height: 40)
            flag.backgroundColor = UIColor.blue
            flag.layer.borderColor = UIColor.white.cgColor
            flag.layer.borderWidth = 1
            flag.setTitle("🚩", for: .normal)
            flag.tag=num
            flag.addTarget(self, action: #selector(tap), for: .touchUpInside)
            let longGesture = UILongPressGestureRecognizer(target: self, action:#selector(long) )
            flag.addGestureRecognizer(longGesture)
            self.view.addSubview(flag)
        }
    }
    func clearview() {
        for v in self.view.subviews as [UIView] {
            for index in 1..<82{
                v.viewWithTag(index)?.removeFromSuperview()
            }}
    }
    func generateview(){
        for buttontag in 1..<82{
            
            let button = UIButton(type:.system)
            button.frame=CGRect(x: 7+((buttontag-1)%9)*40, y: 135+((buttontag-1)/9-1)*40, width: 40, height: 40)
            button.backgroundColor = UIColor.blue
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.borderWidth = 1
            
            button.tag=buttontag
            button.addTarget(self, action: #selector(tap), for: .touchUpInside)
            let longGesture = UILongPressGestureRecognizer(target: self, action:#selector(long) )
            button.addGestureRecognizer(longGesture)
            self.view.addSubview(button)
            playing=true
        }
        
    }
    func changewhite(){
        
        for x in 0...80{
            if colorchange[x] == 1
            {
                opened[x]=1
                let button1 = UIButton(type:.system)
                button1.frame=CGRect(x: 7+((x)%9)*40, y: 135+((x)/9-1)*40, width: 40, height: 40)
                button1.layer.borderColor = UIColor.white.cgColor
                button1.layer.borderWidth = 1
                button1.backgroundColor = UIColor.white
                button1.tag=x+1
                
                if bombnumber[x] != 0{
                    button1.setTitle(String(bombnumber[x]), for: .normal)
                    button1.setTitleColor(UIColor.blue,for: .normal)
                    
                }
                button1.isEnabled = false
                self.view.addSubview(button1)
            }
        }
        
    }
    @IBOutlet weak var end: UILabel!
    
    @IBOutlet weak var countbombs: UILabel!
    
    @IBOutlet weak var timing: UILabel!
    
    @IBOutlet weak var record: UILabel!
    @IBAction func start(_ sender: UIButton) {
        clearview()
        timer.invalidate()
        timing.text="time:0:00"
        countbombs.text=" "
        end.text = "start!"
        bombnumber = [Int](repeating: 0, count: 81)
        bombs = 0
        openednumber = 0
        opened = [Int](repeating: 0, count: 81)
        colorchange = [Int](repeating: 0, count: 81)
        generatebomb()
        dog = [Int](repeating: 0, count: 81)
        seconds = 0
        minutes = 0
        records.text=" "
        first = true
        
        generateview()
        
    }
    
    @objc func counttime()
    {
        seconds+=1
        if seconds==60
        {
            minutes+=1
            seconds=0
        }
        if minutes>=60{
            timing.text="you idiot please stop playing this"
        }
        else{if(seconds<10){
            timing.text="time:"+String(minutes)+":"+"0"+String(seconds)
        }
        else{
            timing.text="time:"+String(minutes)+":"+String(seconds)
            }
        }
    }
    
    @IBOutlet weak var records: UILabel!
    
    @IBAction func Showinfo(_ sender: AnyObject) {
        //实例化一个信息界面
        let controller = InfoViewController(nibName:"InfoViewController", bundle:nil)
        //详细界面出现的动画方式
        controller.modalTransitionStyle = .coverVertical
        //界面跳转
        self.present(controller, animated:true, completion:nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func tap(sender: UIButton!) {
        
        
        
        if playing{
            
            if sender.title(for: .normal)=="🚩"{
                
                sender.backgroundColor = UIColor.blue
                sender.setTitle(String(bombnumber[sender.tag-1]), for: .normal)
                sender.setTitleColor(UIColor.blue,for: .normal)
            }
            else{
                if first{
                    timer = Timer.scheduledTimer(timeInterval:1, target: self,selector: #selector(counttime),userInfo: nil,repeats: true)
                    ifthereisabomb[sender.tag-1]=2
                    for x in 0...80{
                        
                        
                        countbomb(bomb: ifthereisabomb[x],x: x)
                        
                    }
                    countbombs.text = "bombs:"+String(bombs)
                    first = false
                }
                
                
                if bombnumber[sender.tag-1] > 0 && bombnumber[sender.tag-1] < 9
                {
                    sender.setTitle(String(bombnumber[sender.tag-1]), for: .normal)
                    sender.setTitleColor(UIColor.blue,for: .normal)
                    opened[sender.tag-1]=1
                    sender.backgroundColor = UIColor.white
                    sender.isEnabled = false
                    
                }
                if bombnumber[sender.tag-1]==0
                {
                    sender.setTitle(" ", for: .normal)
                    
                    extend(num: sender.tag-1)
                    
                    changewhite()
                    
                }
                openednumber = 0
                for index in 0..<81{
                    if opened[index]==1{
                        openednumber+=1
                    }
                }
                
                if openednumber == (81-bombs){
                    timer.invalidate()
                    end.text = "you win!"
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let context = appDelegate.persistentContainer.viewContext
                    let time = NSEntityDescription.insertNewObject(forEntityName: "Time",
                                                                   into: context) as! Time
                    let fetchRequest = NSFetchRequest<Time>(entityName: "Time")
                    // fetchRequest.fetchLimit = 10 //限定查询结果的数量
                    // fetchRequest.fetchOffset = 0 //查询的偏移量
                    time.seconds=Int16(seconds)
                    time.minutes=Int16(minutes)
                    time.bombnum=Int16(bombs)
                    do {
                        
                        try context.save()
                        //print("saved.")
                    }
                    catch {
                        fatalError("不能保存：\(error)")
                    }
                    do{
                        let fetchedObjects = try context.fetch(fetchRequest)
                        var k = 1
                        for info in fetchedObjects{
                            //print("seconds=\(info.seconds)")
                            //print("minutes=\(info.minutes)")
                            if(info.minutes==Int16(minutes))
                            {
                                if(info.seconds==0&&info.minutes==0)
                                {
                                    k = 0
                                    context.delete(info)
                                    try! context.save()
                                }
                                else if(info.seconds<Int(seconds))
                                {
                                    //print("new record!")
                                    
                                     k = 0
                                    //records.textColor=UIColor.red
                                    //records.text="new record!"
                                }
                            }
                            else if (info.minutes<Int16(minutes))
                            {
                                //print("new record!")
                                
                                 k = 0
                                //records.textColor=UIColor.red
                                //records.text="new record!"
                            }
                            
                        }
                        if k == 1{
                            records.textColor=UIColor.red
                            records.text="new record!"
                        }
                    }catch  {
                                fatalError("\(error)")
                                
                    }
                    
                    
                    
                    
                    playing = false
                }
                
                if bombnumber[sender.tag-1]>=9 {
                    timer.invalidate()
                    sender.setTitle(String("💣"),for:.normal)
                    sender.backgroundColor = UIColor.red
                    sender.isEnabled = false
                    playing = false
                    end.text="boom!"
                }
                
            }}
        
        
    }
    
}


