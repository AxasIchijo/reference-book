//
//  ViewController.swift
//  reference-book
//
//  Created by AXLT0221-AP on 2022/02/09.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var priceText: UITextField!
    @IBOutlet weak var discountSlider: UISlider!
    @IBOutlet weak var calculateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initPriceText()
        discountSlider.value = 5.0
        culculateBtnUpdate()
    }
    
    // 数字押下時の処理
    @IBAction func tap_number(sender: UIButton) {
        if let price = Int(priceText.text! + sender.titleLabel!.text!) {
            priceText.text = "\(price)"
        }
    }
    
    // C(clear)押下時の処理
    @IBAction func tap_clear(_ sender: Any) {
        priceText.text! = "0"
    }
    
    // 値引き価格の変更
    @IBAction func slide_discount(_ sender: Any) {
        culculateBtnUpdate()
    }
    
    // 画面遷移時の引き継ぎ処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultViewController = segue.destination as! ResultViewController
        
        // 入力値を遷移先画面に引き継ぐ
        if let price = Int(priceText.text!) {
            resultViewController.standerdPrice = price
            resultViewController.discountRate = floor(discountSlider!.value) / 10.0
        }
    }
    
    
    @IBAction func restart(_ segue: UIStoryboardSegue) {
        culculateBtnUpdate()
    }
    
    // テキストフィールドの初期化
    private func initPriceText() {
        priceText.text! = "0"
    }
    
    // 計算ボタンのラベル更新
    private func culculateBtnUpdate() {
        calculateBtn.setTitle("\(Int(discountSlider!.value) * 10)%値引きする", for: calculateBtn.state)
    }
}

