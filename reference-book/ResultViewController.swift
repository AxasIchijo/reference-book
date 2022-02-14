//
//  ResultViewController.swift
//  reference-book
//
//  Created by AXLT0221-AP on 2022/02/09.
//

import UIKit

class ResultViewController: UIViewController {
    var discountRate : Float = 0.1
    
    var standerdPrice : Int = 0

    @IBOutlet weak var calculated_price: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 割引額を算出
        let discount = Float(standerdPrice) * discountRate
        
        // 割引後の価格を算出
        let discountPrice = standerdPrice - Int(discount)
        
        // 計算価格を計算結果に反映
        calculated_price.text = "\(discountPrice)"
    }
    
    @IBAction func clear(_ segue: Any) {
        calculated_price.text = "0"
    }
}
