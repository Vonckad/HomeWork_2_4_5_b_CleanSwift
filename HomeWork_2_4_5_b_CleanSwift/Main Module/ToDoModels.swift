//
//  ToDoModels.swift
//  HomeWork_2_4_5_b_CleanSwift
//
//  Created by Vlad Ralovich on 2/22/21.
//

import UIKit
import RealmSwift

enum ToDoModels {
  
  // MARK: - Something
    
  enum Something {
    struct Request {
        var taskName: String
    }
    
    struct Response {
        var myTask: String!

        let realm = try! Realm()
        
        var toDo: Results<PersistanceRealm> {
            get { return realm.objects(PersistanceRealm.self)}
        }
    }
    
    struct ViewModel {
       
        var task: [String]
    }
  }
}

class PersistanceRealm: Object {
    @objc dynamic var name = ""
}
