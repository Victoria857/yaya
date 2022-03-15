//
//  NewProjectViewController.swift
//  TrainingTask
//
//  Created by Tishkovskaya, Viktoria on 22.02.22.


import UIKit

class NewProjectViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var nameProjectTextField: UITextField!
    @IBOutlet weak var descriptionProjectTextField: UITextField!
    
    weak var delegate: UITableViewDelegate?
    
    var projectName: String?
    var projectDescription: String?
    var projectIndex: Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
        
        nameProjectTextField.text = projectName
        descriptionProjectTextField.text = projectDescription
    }
    
  
    @IBAction func didTapSaveButton(_ sender: Any) {
        spinner.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            guard let nameProject = self.nameProjectTextField.text, !nameProject.isEmpty, let descriptionProject = self.descriptionProjectTextField.text, !descriptionProject.isEmpty else { return }
            BaseProject.shared.saveProject(nameProject: nameProject, descriptionProject: descriptionProject, index: self.projectIndex)
            self.navigationController?.popViewController(animated: true)
        }
        spinner.stopAnimating()
        
    }
 

}


