//
//  ViewController.swift
//  reference-book
//
//  Created by AXLT0221-AP on 2022/02/09.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    var todoList = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 長さを返却
        return self.todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        
        let todoTitle = self.todoList[indexPath.row]
        cell.textLabel?.text = todoTitle
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapAddButton(_ sender: Any) {
        // ダイアログ生成
        let alertController = UIAlertController(title: "Todo追加", message: "Todoを入力してください。", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField(configurationHandler: nil)
        
        // OKボタン追加
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            (action: UIAlertAction) in
            if let textField = alertController.textFields?.first {
                // 入力値をTodoリストに挿入
                self.todoList.insert(textField.text!,at: 0)
                self.tableView.insertRows(at: [IndexPath(row:0,section: 0)], with: UITableView.RowAnimation.right)
            }
        }
        alertController.addAction(okAction)
        
        // キャンセルボタン追加
        let cancelButton = UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(cancelButton)
        
        // ダイアログ表示
        present(alertController, animated: true, completion: nil)
    }
    
}

