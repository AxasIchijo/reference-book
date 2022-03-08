//
//  TodoList.swift
//  reference-book
//
//  Created by AXLT0221-AP on 2022/03/08.
//

import Foundation

class MyTodo: NSObject, NSSecureCoding {
    var todoTitle : String?
    
    var todoDone : Bool = false
    
    func encode(with coder: NSCoder) {
        coder.encode(todoTitle, forKey: "todoTitle")
        coder.encode(todoDone, forKey: "todoDone")
    }
    
    override init() {}
    
    required init?(coder: NSCoder) {
        if let title = coder.decodeObject(forKey: "todoTitle") as? String {
            self.todoTitle = title
        }
        
        self.todoDone = coder.decodeBool(forKey: "todoDone")
    }
    
    static var supportsSecureCoding: Bool {
        return true
    }
    
    
}
