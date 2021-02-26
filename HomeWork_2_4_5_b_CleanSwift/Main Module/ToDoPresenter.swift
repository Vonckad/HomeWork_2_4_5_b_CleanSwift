//
//  ToDoPresenter.swift
//  HomeWork_2_4_5_b_CleanSwift
//
//  Created by Vlad Ralovich on 2/22/21.
//

import UIKit

protocol ToDoPresentationLogic {
    func presentTask(_ responce: ToDoModels.Something.Response)
}

final class ToDoPresenter: ToDoPresentationLogic {

  // MARK: - Public Properties

  weak var viewController: ToDoDisplayLogic?

  // MARK: - Private Properties
  
  //

  // MARK: - Presentation Logic
    func presentTask(_ responce: ToDoModels.Something.Response) {

        var viewModel = ToDoModels.Something.ViewModel(task: [])
        
        for item in responce.toDo {
            viewModel.task.append(item.name)
        }
        
        viewController?.displayData(viewModel)
    }
}
