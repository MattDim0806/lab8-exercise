//
//  raceVC.swift
//  lab8-exercise
//
//  Created by 楊皓麟 on 2023/2/4.
//

import UIKit

class raceVC: UIViewController {
    @IBOutlet weak var rabbitProgress: UIProgressView!
    @IBOutlet weak var turtleProgress: UIProgressView!
    var rabbitDis = 0
    var turtleDis = 0
    var finishFlag = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startBtn(_ sender: Any) {
        rabbitDis = 0
        turtleDis = 0
        finishFlag = false
        rabbitProgress.progress = 0
        turtleProgress.progress = 0
        let secQueue = DispatchQueue.global()
        secQueue.async {
            while(self.rabbitDis<100 && self.turtleDis<100){
                self.rabbitRun()
                self.showProgress()
            }
            self.showWinner()
        }
        secQueue.async {
            while(self.rabbitDis<100 && self.turtleDis<100){
            self.turtleRun()
            self.showProgress()
            }
            self.showWinner()
        }
    }
    
    func rabbitRun(){
        let move = Int.random(in: 1...10)
        rabbitDis += move
        var sleepTime = Int.random(in: 1...10)
        if(turtleDis>68){
            sleepTime = 1
        }
        print("兔子走", move,"休息", sleepTime)
        usleep(useconds_t(sleepTime*50000))
    }
    
    func turtleRun(){
        turtleDis += 2
        usleep(50000)
    }
    
    func showProgress(){
        let mainQueue = DispatchQueue.main
        mainQueue.async {
            self.rabbitProgress.progress = Float(self.rabbitDis)/100
            self.turtleProgress.progress = Float(self.turtleDis)/100
        }
    }
    
    func showWinner(){
        if(!finishFlag){
            finishFlag = true
            var winMsg = ""
            if(rabbitDis > turtleDis){
                winMsg = "兔子勝利"
            }
            else if(rabbitDis < turtleDis){
                winMsg = "烏龜勝利"
            }
            else{
                winMsg = "平手"
            }
            let mainQueue = DispatchQueue.main
            mainQueue.async {
                let msgView = UIAlertController(title: winMsg, message: "", preferredStyle: .alert)
                let determineAction = UIAlertAction(title: "確定", style: .default, handler: nil)
                msgView.addAction(determineAction)
                self.present(msgView, animated: true, completion: nil)
            }
        }
    }
}
