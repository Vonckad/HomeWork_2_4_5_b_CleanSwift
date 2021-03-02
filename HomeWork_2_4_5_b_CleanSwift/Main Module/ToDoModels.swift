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
        var iD: Int
    }
    
    struct Response {
        let realm = try! Realm()
        var toDo: Results<PersistanceRealm> {
            get { return realm.objects(PersistanceRealm.self)}
        }
    }
    
    struct ViewModel {
        var task: [Task] = []
        struct Task {
            var task: String
            var identifier: Int
      }
    }
  }
}

class PersistanceRealm: Object {
    @objc dynamic var name = ""
    @objc dynamic var identifier = 0
}
