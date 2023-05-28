//
//  ToDoListViewController.swift
//  ToDoList
//
//  Created by Mohit on 27/05/23.
//

import UIKit

class ToDoListViewController: UIViewController {

    //MARK: - Outlet
    @IBOutlet weak var tblToDoList: UITableView!
    
    //MARK: - Variable
    var viewModel = ToDoListViewModel()
    var warningView:DeleteAlertView?
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindableUI()
        registerTableCell()
        addWarningView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchToDoList(sort: viewModel.sortBy.value)
    }
    
   //MARK: - Function
    func bindableUI() {
        viewModel.arrToDoList.bind { [weak self] arrToDo in
            self?.tblToDoList.isHidden = arrToDo.count == 0
            self?.tblToDoList.reloadData()
        }
        viewModel.sortBy.bind { [weak self] sort in
            self?.viewModel.fetchToDoList(sort: sort)
        }
    }
    
    
    func registerTableCell() {
        tblToDoList.registerCell(ToDoListCell.self)
        tblToDoList.registerCell(ToDoHeaderListCell.self)
        tblToDoList.registerCell(ToDoFooterListCell.self)
        tblToDoList.delegate = self
        tblToDoList.dataSource = self
    }
    
    func addWarningView() {
        warningView = DeleteAlertView(frame: self.view.frame)
        warningView?.addView(on: self.view, selectHandler: { [weak self] todoTask,isMarkComplete in
            if let todo = todoTask{
                if isMarkComplete {
                    self?.callMarkComplete(task: todo)
                }else{
                    self?.callDelete(task: todo)
                }
            }
            self?.warningView?.hide()
        })
    }
    func callWarning(todo:ToDoListItem,isMarkComplete:Bool) {
        warningView?.updateWarningText(todo: todo, isMarkComplete: isMarkComplete)
        warningView?.show()
    }
    
    func callDelete(task:ToDoListItem) {
        self.viewModel.deleteTask(task: task, completion: {[weak self] err in
            if let error = err {
                self?.showAlert(nil, error, {})
            }
        })
    }
    
    func callMarkComplete(task:ToDoListItem) {
        guard !task.markedStatus else {return}
        self.viewModel.markCompleteTask(task: task, completion: {[weak self] err in
            if let error = err {
                self?.showAlert(nil, error, {})
            }
        })
        
    }
    
    //MARK: - Action
    @IBAction func actionSort(_ sender: Any) {
        if viewModel.arrToDoList.value.count == 0{
            return
        }
        self.showActionSheet(nil, StringConstant.StaticText.sort, self.viewModel.sortBy.value) { sort in
            self.viewModel.sortBy.value = sort
        }
    }
    
}

extension ToDoListViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrToDoList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tblToDoList.dequeueCell(ToDoListCell.self, indexPath: indexPath) {
            cell.selectionStyle = .none
            cell.setData(model: viewModel.arrToDoList.value[indexPath.row])
            cell.actionDelete = { [weak self] in
                guard let `self` = self else {return}
                self.callWarning(todo: self.viewModel.arrToDoList.value[indexPath.row], isMarkComplete: false)
            }
            cell.actionMarkComplete = { [weak self] in
                guard let `self` = self else {return}
                self.callWarning(todo: self.viewModel.arrToDoList.value[indexPath.row], isMarkComplete: true)
            }
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerCell = tblToDoList.dequeueCell(ToDoHeaderListCell.self){
            return headerCell
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let headerCell = tblToDoList.dequeueCell(ToDoFooterListCell.self){
            return headerCell
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.arrToDoList.value[indexPath.row]
        if !model.markedStatus, let date = model.endDate, date>Date(){
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: StringConstant.ControllerName.addNewTask) as? AddNewTaskViewController {
                vc.viewModel = AddNewTaskViewModel(objTodoItem: viewModel.arrToDoList.value[indexPath.row])
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else {
            self.showAlert(nil, StringConstant.Error.warning, {})
        }
       
                
    }
   
}

