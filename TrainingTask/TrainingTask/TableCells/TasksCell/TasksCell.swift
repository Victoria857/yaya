//
//  TasksCell.swift
//  TrainingTask
//
//  Created by Tishkovskaya, Viktoria on 22.02.22.
//

import UIKit

enum StatusVariants: String {
    case notStarted = "Не начата"
    case inProcess = "В процессе"
    case completed = "Завершена"
    case postponed = "Отложена"
}

class TasksCell: UITableViewCell {

    @IBOutlet weak var statusTaskView: UIView!
    @IBOutlet weak var nameTaskLabel: UILabel!
    @IBOutlet weak var nameProjectLabel: UILabel!
    
//    weak var delegateString: SendDataTasksDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(task: BaseTask.Task) {
        nameTaskLabel.text = task.nameTask
        nameProjectLabel.text = task.nameProject
        if task.status == StatusVariants.notStarted.rawValue {
            statusTaskView.backgroundColor = .gray
        } else if task.status == StatusVariants.inProcess.rawValue {
            statusTaskView.backgroundColor = .blue
        } else if task.status == StatusVariants.completed.rawValue {
            statusTaskView.backgroundColor = .green
        } else if task.status == StatusVariants.postponed.rawValue {
            statusTaskView.backgroundColor = .red
        }
    }
}
