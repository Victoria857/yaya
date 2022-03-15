//
//  ProjectViewController.swift
//  TrainingTask
//
//  Created by Tishkovskaya, Viktoria on 22.02.22.
//

import UIKit

protocol SendDataProjectDelegate: AnyObject {
    func sendDataProject(project: BaseProject.Project)
}

class ProjectViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegateProject: SendDataProjectDelegate?
    var select: Bool?
    var projects: [BaseProject.Project] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        let refreshItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRefreshButton))
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.setRightBarButtonItems([addItem, refreshItem], animated: true)

        let nib = UINib(nibName: String(describing: ProjectCell.self), bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: String(describing: ProjectCell.self))
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        spinner.startAnimating()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NetworkManager.shared.getProjects(completion: getProjectsData)
    }
    
    func getProjectsData(projects: [BaseProject.Project]) {
        self.projects = projects
        self.tableView.reloadData()
        spinner.stopAnimating()
    }
 
    
    @objc func didTapAddButton() {
        let controller = NewProjectViewController(nibName: String(describing: NewProjectViewController.self), bundle: nil)
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }

    @objc func didTapRefreshButton() {
        spinner.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            NetworkManager.shared.getProjects { projects in
                self.projects = projects
                self.tableView.reloadData()
                self.spinner.stopAnimating()
            }
        }
    }
    
}

extension ProjectViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProjectCell.self), for: indexPath)
        guard let arrayCell = cell as? ProjectCell else { return cell }
        arrayCell.setupCell(project: projects[indexPath.row])
        return arrayCell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            projects.remove(at: indexPath.row)
            BaseProject.shared.projects.remove(at: indexPath.row)
            self.spinner.startAnimating()
            tableView.deleteRows(at: [indexPath], with: .fade)
            let newArray = UserDefaults.standard.value(forKey: "projects")
            UserDefaults.standard.set(newArray, forKey: "projects")
            tableView.endUpdates()
            self.spinner.stopAnimating()
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if self.select == true {
            self.delegateProject?.sendDataProject(project: projects[indexPath.row])
            self.navigationController?.popViewController(animated: true)
        } else {
            let editVC = NewProjectViewController(nibName: String(describing: NewProjectViewController.self), bundle: nil)
            editVC.delegate = self
            editVC.projectName = projects[indexPath.row].nameProject
            editVC.projectDescription = projects[indexPath.row].descriptionProject
            editVC.projectIndex = indexPath.row
            self.navigationController?.pushViewController(editVC, animated: true)
        }
    }
}

