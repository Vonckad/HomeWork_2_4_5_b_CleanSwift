//
//  ToDoInteractor.swift
//  HomeWork_2_4_5_b_CleanSwift
//
//  Created by Vlad Ralovich on 2/22/21.
//

import Foundation
import RealmSwift

protocol ToDoBusinessLogic {
    func fetchTask(newTask: ToDoModels.Something.Request)
//    func load()
}

protocol ToDoDataStore {

}

final class ToDoInteractor: ToDoBusinessLogic, ToDoDataStore {

  // MARK: - Public Properties

  var presenter: ToDoPresentationLogic?
  lazy var worker: ToDoWorkingLogic = ToDoWorker()

  // MARK: - Private Properties
    
  //

  // MARK: - Business Logic
    func fetchTask(newTask: ToDoModels.Something.Request) {
       
        let responce = ToDoModels.Something.Response(myTask: newTask.taskName)
        presenter?.presentTask(responce)

//        let item = PersistanceRealm()
//        item.name = newTask.taskName
//
//        try! responce.realm.write {
//                responce.realm.add(item)
//            }
//        presenter?.presentTaskLists(responce.toDo)

        
    }
    
//    func load() {
//        let responce = ToDoModels.Something.Response(myTask: "")
//        presenter?.presentTaskLists(responce.toDo)
//    }
    
  //
}
