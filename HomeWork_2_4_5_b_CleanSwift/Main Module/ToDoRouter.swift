//
//  ToDoRouter.swift
//  HomeWork_2_4_5_b_CleanSwift
//
//  Created by Vlad Ralovich on 2/22/21.
//

import UIKit

protocol ToDoRoutingLogic {

}

protocol ToDoDataPassing {
  var dataStore: ToDoDataStore? { get }
}

final class ToDoRouter: ToDoRoutingLogic, ToDoDataPassing {

  // MARK: - Public Properties

  weak var viewController: ToDoViewController?
  var dataStore: ToDoDataStore?
  
  // MARK: - Private Properties
  
  //

  // MARK: - Routing Logic
  
  //

  // MARK: - Navigation
  
  //

  // MARK: - Passing data
  
  //
}
