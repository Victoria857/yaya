//
//  TasksViewController.swift
//  TrainingTask
//
//  Created by Tishkovskaya, Viktoria on 22.02.22.
//

import UIKit

class TasksViewController: UIViewController {

   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var tasks: [BaseTask.Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        let refreshItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRefreshButton))
       
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.setRightBarButtonItems([addItem, refreshItem], animated: true)
        let nib = UINib(nibName: String(describing: TasksCell.self), bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: String(describing: TasksCell.self))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        spinner.startAnimating()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NetworkManager.shared.getTasks(completion: getTasksData)
    }
    
    func getTasksData(tasks: [BaseTask.Task]) {
        self.tasks = tasks
        spinner.stopAnimating()
        self.tableView.reloadData()
    }
 
    
    @objc func didTapAddButton() {
        let controller = NewTasksViewController(nibName: String(describing: NewTasksViewController.self), bundle: nil)
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func didTapRefreshButton() {
        spinner.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            NetworkManager.shared.getTasks { tasks in
                self.tasks = tasks
                self.tableView.reloadData()
                self.spinner.stopAnimating()
            }
        }
    }

}

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TasksCell.self), for: indexPath)
        guard let arrayCell = cell as? TasksCell else { return cell }
        arrayCell.setupCell(task: tasks[indexPath.row])
        return arrayCell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            spinner.startAnimating()
            tableView.beginUpdates()
            tasks.remove(at: indexPath.row)
            BaseTask.shared.tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            let newArray = UserDefaults.standard.value(forKey: "tasks")
            UserDefaults.standard.set(newArray, forKey: "tasks")
            tableView.endUpdates()
            spinner.stopAnimating()
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        spinner.startAnimating()
        let editVC = NewTasksViewController(nibName: String(describing: NewTasksViewController.self), bundle: nil)
        editVC.delegate = self
        editVC.taskName = tasks[indexPath.row].nameTask
        editVC.projectName = tasks[indexPath.row].nameProject
        editVC.taskTime = tasks[indexPath.row].timeTask
        editVC.taskStartDate = tasks[indexPath.row].startDate
        editVC.taskEndDate = tasks[indexPath.row].endDate
        editVC.taskExecutor = tasks[indexPath.row].executor
        editVC.taskIndex = indexPath.row
        spinner.stopAnimating()
        navigationController?.pushViewController(editVC, animated: true)
    }
    
}

