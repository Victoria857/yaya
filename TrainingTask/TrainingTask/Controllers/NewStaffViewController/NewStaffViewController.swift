//
//  NewStaffViewController.swift
//  TrainingTask
//
//  Created by Tishkovskaya, Viktoria on 22.02.22.
//

import UIKit

class NewStaffViewController: UIViewController {

    @IBOutlet weak var nameStaffTextField: UITextField!
    @IBOutlet weak var surnameStaffTextField: UITextField!
    @IBOutlet weak var patronymicStaffTextField: UITextField!
    @IBOutlet weak var employeePositionTextField: UITextField!
    
    

    weak var delegate: UITableViewDelegate?
    
    var staffName: String?
    var staffSurname: String?
    var staffPatronymic: String?
    var staffPosition: String?
    var staffIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameStaffTextField.text = staffName
        surnameStaffTextField.text = staffSurname
        patronymicStaffTextField.text = staffPatronymic
        employeePositionTextField.text = staffPosition
    }
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        guard let nameStaff = nameStaffTextField.text, !nameStaff.isEmpty, let surnameStaff = surnameStaffTextField.text, !surnameStaff.isEmpty, let patronymicStaff = patronymicStaffTextField.text, !patronymicStaff.isEmpty, let employeePosition = employeePositionTextField.text, !employeePosition.isEmpty else { return }
        BaseStaff.shared.saveStaff(nameStaff: nameStaff, surnameStaff: surnameStaff, patronymicStaff: patronymicStaff, employeePosition: employeePosition, index: staffIndex)
        
        navigationController?.popViewController(animated: true)
    }
    
    
}
