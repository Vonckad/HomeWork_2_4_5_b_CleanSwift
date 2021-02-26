//
//  ToDoInteractor.swift
//  HomeWork_2_4_5_b_CleanSwift
//
//  Created by Vlad Ralovich on 2/22/21.
//

import Foundation

protocol ToDoBusinessLogic {
    func addTask(newTask: ToDoModels.Something.Request)
    func deleteTask(index: Int) // не знаю, правильно ли так передавать индекс выбранной ячейки в CleanSwift
    func load()
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
    func addTask(newTask: ToDoModels.Something.Request) {
       
        let responce = ToDoModels.Something.Response(myTask: newTask.taskName)

        let item = PersistanceRealm()
        item.name = newTask.taskName

        try! responce.realm.write {
                responce.realm.add(item)
            }
        
        presenter?.presentTask(responce)
        
    }
    
    func deleteTask(index: Int) {
        let responce = ToDoModels.Something.Response()
        
        try! responce.realm.write({
            responce.realm.delete(responce.toDo[index])
        })
        presenter?.presentTask(responce)
    }

    func load() {
        let responce = ToDoModels.Something.Response()
        presenter?.presentTask(responce)
    }
  //
}
