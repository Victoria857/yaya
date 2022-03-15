//
//  NewTasksViewController.swift
//  TrainingTask
//
//  Created by Tishkovskaya, Viktoria on 23.02.22.
//

import UIKit


class NewTasksViewController: UIViewController, UITableViewDelegate, SendDataProjectDelegate, SendDataStaffDelegate {
   
    @IBOutlet weak var nameTaskTextField: UITextField!
    @IBOutlet weak var nameProjectTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var statusTextField: UITextField!
    @IBOutlet weak var executorTextField: UITextField!
    
    weak var delegate: UITableViewDelegate?
//    var timePicker = UIPickerView()
    private var startDatePicker: UIDatePicker?
    private var endDatePicker: UIDatePicker?
    var statusTaskPicker = UIPickerView()
    
    var statusVariants: [String] = ["Не начата", "В процессе", "Завершена", "Отложена"]

    var taskName: String?
    var projectName: String?
    var taskTime: String?
    var taskStartDate: String?
    var taskEndDate: String?
    var taskStatus: String?
    var taskExecutor: String?
    var taskIndex: Int?
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        statusTaskPicker.dataSource = self
        statusTaskPicker.delegate = self
        
        startDatePicker = UIDatePicker()
        startDatePicker?.datePickerMode = .date
        if #available(iOS 14.0, *) {
            startDatePicker?.preferredDatePickerStyle = .inline
        } else {
            // Fallback on earlier versions
        }
        endDatePicker = UIDatePicker()
        endDatePicker?.datePickerMode = .date
        if #available(iOS 14.0, *) {
            endDatePicker?.preferredDatePickerStyle = .inline
        } else {
    
        }
        
        statusTextField.inputView = statusTaskPicker
        startDateTextField.inputView = startDatePicker
        endDateTextField.inputView = endDatePicker
        startDateTextField.inputAccessoryView = createToolBarForStartDatePicker()
        endDateTextField.inputAccessoryView = createToolBarForEndDatePicker()
        statusTextField.inputAccessoryView = createToolBarForStatusPicker()
        
        statusTaskPicker.tag = 1001
        
        nameTaskTextField.text = taskName
        nameProjectTextField.text = projectName
        timeTextField.text = taskTime
        startDateTextField.text = taskStartDate
        endDateTextField.text = taskEndDate
        statusTextField.text = taskStatus
        executorTextField.text = taskExecutor
        goToAddProjectVC()
        goToAddStaffVC()
    }

    func sendDataProject(project: BaseProject.Project) {
        nameProjectTextField.text = project.nameProject
    }
    
    func sendDataStaff(staff: BaseStaff.Staff) {
        executorTextField.text = staff.surnameStaff
    }
    
    func createToolBarForStartDatePicker() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(didTapDoneButtonInStartDatePicker))
        toolBar.setItems([doneButton], animated: true)
        return toolBar
    }

    func createToolBarForEndDatePicker() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(didTapDoneButtonInEndDatePicker))
        toolBar.setItems([doneButton], animated: true)
        return toolBar
    }
    
    @objc func didTapDoneButtonInStartDatePicker() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "yyyy-MM-dd"
        startDateTextField.text = dateFormatter.string(from: startDatePicker!.date)
        self.view.endEditing(true)
    }
    
    @objc func didTapDoneButtonInEndDatePicker() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "yyyy-MM-dd"
        endDateTextField.text = dateFormatter.string(from: endDatePicker!.date)
        self.view.endEditing(true)
    }
    
    func createToolBarForStatusPicker() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(didTapDoneButtonInStatusPicker))
        toolBar.setItems([doneButton], animated: true)
        return toolBar
    }
    
    @objc func didTapDoneButtonInStatusPicker() {
        self.view.endEditing(true)
    }
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        guard let nameTask = nameTaskTextField.text, !nameTask.isEmpty, let nameProject = nameProjectTextField.text, !nameProject.isEmpty, let timeTask = timeTextField.text, !timeTask.isEmpty, let startDate = startDateTextField.text, !startDate.isEmpty, let endDate = endDateTextField.text, !endDate.isEmpty, let statusTask = statusTextField.text, !statusTask.isEmpty, let executor = executorTextField.text, !executor.isEmpty else { return }
        BaseTask.shared.saveTask(nameTask: nameTask, nameProject: nameProject, timeTask: timeTask, startDate: startDate, endDate: endDate, status: statusTask, executor: executor, index: taskIndex)
        navigationController?.popViewController(animated: true)        
    }
    
    func goToAddProjectVC() {
        let projectTextField = UITapGestureRecognizer(target: self, action: #selector(addNewProjectAction(sender:)))
        nameProjectTextField.addGestureRecognizer(projectTextField)
    }

    @objc func addNewProjectAction(sender: UITapGestureRecognizer) {
        let controller = ProjectViewController(nibName: String(describing: ProjectViewController.self), bundle: nil)
        controller.delegateProject = self
        controller.select = true
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func goToAddStaffVC() {
        let employeeTextField = UITapGestureRecognizer(target: self, action: #selector(addNewEmployeeAction(sender:)))
        executorTextField.addGestureRecognizer(employeeTextField)
    }

    @objc func addNewEmployeeAction(sender: UITapGestureRecognizer) {
        let controller = StaffViewController(nibName: String(describing: StaffViewController.self), bundle: nil)
        controller.delegateStaff = self
        controller.select = true
        navigationController?.pushViewController(controller, animated: true)
    }
    

}


extension NewTasksViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1001 {
            return statusVariants.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1001 {
            return "\(statusVariants[row])"
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1001 {
            statusTextField.text = "\(statusVariants[row])"
        }
    }
}
    


