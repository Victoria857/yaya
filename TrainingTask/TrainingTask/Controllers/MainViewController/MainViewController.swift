//
//  MainViewController.swift
//  TrainingTask
//
//  Created by Tishkovskaya, Viktoria on 22.02.22.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet weak var projectButton: UIButton!
    @IBOutlet weak var tasksButton: UIButton!
    @IBOutlet weak var staffButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        settingsButton.isHidden = true
        settingsButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        settingsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        projectButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        projectButton.titleLabel?.adjustsFontSizeToFitWidth = true
        tasksButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        tasksButton.titleLabel?.adjustsFontSizeToFitWidth = true
        staffButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        staffButton.titleLabel?.adjustsFontSizeToFitWidth = true

        if #available(iOS 13.0, *) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .done, target: self, action: #selector(didTapSettingsButton))
        } else {
            settingsButton.isHidden = false
            settingsButton.addTarget(self, action: #selector(didTapSettingsButton), for: .touchUpInside)
        }
    }
    
    @IBAction func goToProjectView(_ sender: Any) {
        navigationController?.pushViewController(ProjectViewController(nibName: String(describing: ProjectViewController.self), bundle: nil), animated: true)
              
    }
    
    @IBAction func goToTasksView(_ sender: Any) {
        navigationController?.pushViewController(TasksViewController(nibName: String(describing: TasksViewController.self), bundle: nil), animated: true)
    }
    
    @IBAction func goToStaffView(_ sender: Any) {
        navigationController?.pushViewController(StaffViewController(nibName: String(describing: StaffViewController.self), bundle: nil), animated: true)
    }
    
    @objc func didTapSettingsButton() {
        let controller = SettingsViewController(nibName: String(describing: SettingsViewController.self), bundle: nil)
        navigationController?.pushViewController(controller, animated: true)
    }
}
