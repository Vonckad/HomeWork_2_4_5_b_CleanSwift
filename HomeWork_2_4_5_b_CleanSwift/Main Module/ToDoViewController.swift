//
//  ToDoViewController.swift
//  HomeWork_2_4_5_b_CleanSwift
//
//  Created by Vlad Ralovich on 2/22/21.
//

import UIKit
import RealmSwift

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
//    private var realm: Realm!
    private var toDoList = [ToDoModels.Something.ViewModel]()
    
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
//    realm = try! Realm()
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
  
  //

  // MARK: - Private Methods

  private func configure() {
    
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
        toDoList.append(viewModel)
        self.myTableView.reloadData()
    }
}

extension ToDoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = toDoList[indexPath.row].task
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
            let newTask: ToDoModels.Something.Request = .init(taskName: text)
            interactor?.fetchTask(newTask: newTask)
            }
        return self.myTextField.resignFirstResponder()
    }
}
//
