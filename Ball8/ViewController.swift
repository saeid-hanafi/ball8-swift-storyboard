//
//  ViewController.swift
//  Ball8
//
//  Created by Macvps on 4/18/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var luckyNum: UILabel!
    
    @IBOutlet var luckyBtnCheck: UIButton!
    
    @IBOutlet var luckyResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }

    private func setupView() {
        luckyNum.text = ""
        luckyResult.text = ""
        luckyBtnCheck.layer.cornerRadius = 10
        luckyBtnCheck.setShadow(rgb: 0xFFFFFF)
    }
    
}

extension ViewController {
    private func getRandomNumber(upper: UInt32) -> UInt32 {
        return arc4random_uniform(upper)
    }
    
    private func randomBackGround() {
        DispatchQueue.global(qos: .background).async {
            for i in 0...7 {
                DispatchQueue.main.async {
                    if (i == 7) {
                        self.luckyBtnCheck.setTitle("دوباره شانست امتحان کن", for: .normal)
                        
                        self.luckyBtnCheck.backgroundColor = UIColor.blue
                    }else{
                        self.luckyBtnCheck.setTitle(String(self.getRandomNumber(upper: 8)), for: .normal)
                        
                        self.luckyBtnCheck.backgroundColor = UIColor.random
                    }
                }
                usleep(useconds_t(200000))
            }
            DispatchQueue.main.sync {
                self.setChanceTextAndNum()
            }
        }
    }
    
    private func setChanceTextAndNum() {
        let chances = [
            "کارت درسته",
            "پیش به جلو",
            "بیخیال شو",
            "انجامش بده حتما",
            "امروز روز تو نیست",
            "روز شانست هست",
            "مسیر درست برو",
            "ناامید نشو"
        ]
        
        let chanceIndex = getRandomNumber(upper: 8)
        luckyNum.text = String(chanceIndex)
        luckyResult.text = chances[Int(chanceIndex)]
    }
    
    @IBAction func luckyBtnAction(_ sender: Any) {
        randomBackGround()
    }
}

extension CGFloat {
    static var random: CGFloat {
           return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIButton {
    func setShadow(rgb: UInt) {
        self.layer.shadowOffset = CGSize(width: 6, height: 6)
        self.layer.shadowColor = UIColor.init(rgb: rgb).withAlphaComponent(0.5).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 1
    }
}

extension UIColor {
    static var random: UIColor {
           return UIColor(red: .random, green: .random, blue: .random, alpha: 1.0)
    }
    
    convenience init(rgb: UInt) {
        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgb & 0x0000FF) / 255.0, alpha: CGFloat(0.5))
        }
}
