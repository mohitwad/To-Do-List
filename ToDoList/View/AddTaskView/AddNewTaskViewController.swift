//
//  AddNewTaskViewController.swift
//  ToDoList
//
//  Created by Mohit on 28/05/23.
//

import UIKit

class AddNewTaskViewController: UIViewController {

    //MARK: - Outlet
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtFDate: UITextField!
    @IBOutlet weak var viewTimePicker: UIView!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    //MARK: - Variable
    var viewModel = AddNewTaskViewModel()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDate()
        setupKeyboardHiding()
        setupDismissKeyboardGesture()
        bindabelUI()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Function
    func bindabelUI() {
        viewModel.objTodoItem.bind { [weak self] objToDoItem in
            if let item = objToDoItem {
                self?.txtFName.text = item.name
                self?.txtFDate.text = item.endDate?.toString()
                if let date = item.endDate {
                    self?.timePicker.date = date
                }
            }
        }
    }
    
    func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setUpDate() {
        timePicker.minimumDate = Date()
        txtFDate.inputView = viewTimePicker
    }

    func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    //MARK: - Action
    @IBAction func actionTaskCancel(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionSaveTask(_ sender: UIButton) {
        viewModel.validationAndSaveData(name: txtFName.text, time: txtFDate.text, date: timePicker.date) {[weak self] message, isError in
            if isError {
                guard let message = message else {return}
                self?.showAlert(nil, message, {})
            }else {
                self?.showAlert(nil, self?.viewModel.objTodoItem.value != nil ? StringConstant.Success.updateMessage :  StringConstant.Success.successMessage, { [weak self] in
                    self?.navigationController?.popViewController(animated: true)
                })
            }
        }
    }
    
    
    @IBAction func actionPickerDone(_ sender: UIButton) {
        self.txtFDate.text = timePicker.date.toString()
        self.txtFDate.resignFirstResponder()
    }
    
    @IBAction func actionPickerCancel(_ sender: UIButton) {
        self.txtFDate.resignFirstResponder()
    }
}
extension AddNewTaskViewController {
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
                     let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
                     let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height

        // if textField bottom is below keyboard bottom - bump the frame up
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrameY
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == UIGestureRecognizer.State.ended {
            view.endEditing(true) // resign first responder
        }
    }
}
