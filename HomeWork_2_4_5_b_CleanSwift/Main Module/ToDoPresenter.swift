//
//  ToDoPresenter.swift
//  HomeWork_2_4_5_b_CleanSwift
//
//  Created by Vlad Ralovich on 2/22/21.
//

import UIKit
import RealmSwift

protocol ToDoPresentationLogic {
    func presentTask(_ responce: ToDoModels.Something.Response)
//    func presentTaskLists(_ responce: Results<PersistanceRealm>)
}

final class ToDoPresenter: ToDoPresentationLogic {

  // MARK: - Public Properties

  weak var viewController: ToDoDisplayLogic?

  // MARK: - Private Properties
  
  //

  // MARK: - Presentation Logic
    func presentTask(_ responce: ToDoModels.Something.Response) {
        let viewModel: ToDoModels.Something.ViewModel = .init(task: responce.myTask)
        viewController?.displayData(viewModel)
    }
//    func presentTaskLists(_ responce: Results<PersistanceRealm>) {
//
//    }

  //
}
