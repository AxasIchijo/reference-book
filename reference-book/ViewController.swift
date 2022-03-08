//
//  ViewController.swift
//  reference-book
//
//  Created by AXLT0221-AP on 2022/02/09.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    // 保存用オブジェクト
    let userDefaults = UserDefaults.standard
    
    // Todoリスト
    var todoList = [MyTodo]()
    
    // テーブルオブジェクト
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 長さを返却
        return self.todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        
        // セルに値を設定
        let todo = self.todoList[indexPath.row]
        cell.textLabel?.text = todo.todoTitle
        
        // セルの修飾を変更
        if todo.todoDone {
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        } else {
            cell.accessoryType = UITableViewCell.AccessoryType.none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = self.todoList[indexPath.row]
        // トグル
        todo.todoDone = !todo.todoDone
        
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        
        self.save()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // 操作の判定
        if editingStyle == UITableViewCell.EditingStyle.delete {
            // 削除処理
            self.todoList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            
            self.save()
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let storedTodoList = userDefaults.object(forKey: "todoList") as? Data {
            do {
                // デシリアライズしてリストに追加
                if let unarchiveTodoList = try  NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self,  MyTodo.self], from: storedTodoList) as? [MyTodo] {
                    self.todoList.append(contentsOf: unarchiveTodoList)
                }
            } catch {
                // 処理なし
            }
        }
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
                let myTodo = MyTodo()
                myTodo.todoTitle = textField.text!
                myTodo.todoDone = false
                self.todoList.insert(myTodo,at: 0)
                self.tableView.insertRows(at: [IndexPath(row:0,section: 0)], with: UITableView.RowAnimation.right)
            }
            
            self.save()
        }
        alertController.addAction(okAction)
        
        // キャンセルボタン追加
        let cancelButton = UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(cancelButton)
        
        // ダイアログ表示
        present(alertController, animated: true, completion: nil)
    }
    
    func save() {
        // シリアライズして保存
        do {
            let archiveData = try NSKeyedArchiver.archivedData(withRootObject: self.todoList, requiringSecureCoding: true)
            
            self.userDefaults.set(archiveData, forKey: "todoList")
            self.userDefaults.synchronize()
        } catch {
            // 処理なし
        }
    }
}

