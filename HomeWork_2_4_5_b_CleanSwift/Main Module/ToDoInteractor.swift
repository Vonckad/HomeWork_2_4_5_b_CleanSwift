//
//  ToDoInteractor.swift
//  HomeWork_2_4_5_b_CleanSwift
//
//  Created by Vlad Ralovich on 2/22/21.
//

import Foundation

protocol ToDoBusinessLogic {
    func load()
    func addTask(newTask: ToDoModels.Something.Request)
    func removeTask(task: ToDoModels.Something.ViewModel.Task, completed: @escaping () -> ())
}

protocol ToDoDataStore {

}

final class ToDoInteractor: ToDoBusinessLogic, ToDoDataStore {

  // MARK: - Public Properties

  var presenter: ToDoPresentationLogic?
  lazy var worker: ToDoWorkingLogic = ToDoWorker()

  // MARK: - Private Properties
    let responce = ToDoModels.Something.Response()

  //

  // MARK: - Business Logic
    func addTask(newTask: ToDoModels.Something.Request) {
       
        let item = PersistanceRealm()
        item.name = newTask.taskName
        item.identifier = newTask.iD
        
        try! responce.realm.write {
                responce.realm.add(item)
            }
        
        presenter?.presentRealmTask(responce)
        
    }
    
    func removeTask(task: ToDoModels.Something.ViewModel.Task, completed: @escaping () -> ()) {
       
        let realmTaskToDelete = responce.realm.objects(PersistanceRealm.self).filter { $0.identifier == task.identifier }.first
                if let realmTask = realmTaskToDelete {
                    try? responce.realm.write {
                        responce.realm.delete(realmTask)
                    }
                }
            completed()
        presenter?.presentRealmTask(responce)
    }

    func load() {
        presenter?.presentRealmTask(responce)
    }
  //
}
