//
//  ToDoViewController.swift
//  HomeWork_2_4_5_b_CleanSwift
//
//  Created by Vlad Ralovich on 2/22/21.
//

import UIKit

protocol ToDoDisplayLogic: AnyObject {
    func displayData(_ viewModel: ToDoModels.Something.ViewModel)
}

final class ToDoViewController: UIViewController {

  // MARK: - UI Outlets
  
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var bottomAnchorTextField: NSLayoutConstraint!
    @IBOutlet weak var leftAnchorTextField: NSLayoutConstraint!
    @IBOutlet weak var rightAnchorTextField: NSLayoutConstraint!
    //
  
  // MARK: - Public Properties
    
  var interactor: ToDoBusinessLogic?
  var router: (ToDoRoutingLogic & ToDoDataPassing)?

  // MARK: - Private Properties
    
    private var toDoList = ToDoModels.Something.ViewModel(task: [])
    
  //

  // MARK: - Init

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup() {

    let interactor = ToDoInteractor()
    let presenter = ToDoPresenter()
    let router = ToDoRouter()

    interactor.presenter = presenter
    presenter.viewController = self
    router.viewController = self
    router.dataStore = interactor

    self.interactor = interactor
    self.router = router
  }

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }

  // MARK: - Public Methods
    func foundIdTask(index: Int) {
       
        let toDo = ToDoModels.Something.Response()
        
        if toDo.toDo[index].name == toDoList.task[index] {
            let idTask: ToDoModels.Something.Request = .init(taskName: toDoList.task[index], iD: index)
            interactor?.deleteTask(idTask: idTask)
        }
    }
  //

  // MARK: - Private Methods

  private func configure() {

    interactor?.load()
    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (nc) in
        self.bottomAnchorTextField.constant = 320
        self.leftAnchorTextField.constant = 8
        self.rightAnchorTextField.constant = 8
    }
    
    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (nc) in
        self.bottomAnchorTextField.constant = 16
        self.leftAnchorTextField.constant = 120
        self.rightAnchorTextField.constant = 120
        self.myTextField.text = nil
    }
  }
  
  // MARK: - UI Actions
    
  //
}

// MARK: - Display Logic

extension ToDoViewController: ToDoDisplayLogic {
    
    func displayData(_ viewModel: ToDoModels.Something.ViewModel) {
        toDoList = viewModel
        self.myTableView.reloadData()
    }
}

extension ToDoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        foundIdTask(index: indexPath.row)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.task.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = toDoList.task[indexPath.row]
        cell.layer.borderWidth = 10
        cell.layer.borderColor = UIColor.systemGray4.cgColor
        cell.layer.cornerRadius = 20
        return cell
    }
    
    
}
// MARK: - Requests

extension ToDoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let text = self.myTextField.text {
            let newTask: ToDoModels.Something.Request = .init(taskName: text, iD: toDoList.task.endIndex + 1)
            interactor?.addTask(newTask: newTask)
            }
        return self.myTextField.resignFirstResponder()
    }
}
//
