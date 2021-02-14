//
//  LobbyViewContrller.swift
//  TechMon
//
//  Created by Sallivan James on 2021/02/14.
//

import UIKit

class LobbyViewContrller: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var staminaLabel: UILabel!
    
    let techMonManager = techMonManager.shared
    
    var stamina: Int = 100
    var staminaTimer: Timer!
    
    
    
    //アプリが起動した時に一度だけ呼ばれる
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //UIの設定
        nameLabel.text = "勇者"
        staminaLabel.text = "\(stamina) / 100"
        
        //タイマーの設定
        staminaTimer = Timer.scheduledTimer(timerInterval: 3, target: self, selector: #selector(updateStaminaValue), userInfo: nil, repeats: true)
        staminaTimer.fire()
    }
    
    
    
    //ロビーの画面が得るようになる時呼ぶ
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        techMonManager.playBGM(fileName: "lobby")
    }
    
    //ロビー画面が見えなくなる時に呼ぶ
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        techMonManager.stopBGM()
    }
    
    
    @IBAction func toBattle(){
        //スタミナが50以上あればスタミナ50を消費して戦闘画面へ
        if stamina >= 50 {
            
            stamina -= 50
            staminaLabel.text = "\(stamina) / 100"
            performSegue(withIdentifier: "toBattle", sender: nil)
        }else {
            let alert = UIAlertController(title: "バトルに行けません", message: "スタミナをためてください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    //スタミナの回復
    @objc func updateStaminaValue(){
        if stamina < 100 {
            stamina += 1
            staminaLabel.text = "\(stamina) / 100"
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
