//
//  ToDoPresenter.swift
//  HomeWork_2_4_5_b_CleanSwift
//
//  Created by Vlad Ralovich on 2/22/21.
//

import UIKit

protocol ToDoPresentationLogic {
    func presentRealmTask(_ response: ToDoModels.Something.Response)
}

final class ToDoPresenter: ToDoPresentationLogic {

  // MARK: - Public Properties

  weak var viewController: ToDoDisplayLogic?

  // MARK: - Private Properties
  
  //

  // MARK: - Presentation Logic

    func presentRealmTask(_ response: ToDoModels.Something.Response) {
        
        var viewModel = ToDoModels.Something.ViewModel()
        
        for item in response.toDo {
            let reTask = ToDoModels.Something.ViewModel.Task(task: item.name, identifier: item.identifier)
            viewModel.task.append(reTask)
            viewController?.displayData(viewModel)
        }
    }
}
