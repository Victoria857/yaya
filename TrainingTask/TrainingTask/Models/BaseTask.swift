//
//  BaseTask.swift
//  TrainingTask
//
//  Created by Tishkovskaya, Viktoria on 3.03.22.
//

import Foundation

class BaseTask {
    let defaults = UserDefaults.standard
    static let shared = BaseTask()
    

    class Task: Codable {
        var nameTask: String!
        var nameProject: String!
        var timeTask: String!
        var startDate: String!
        var endDate: String!
        var status: String!
        var executor: String!
        
        private init() {}
        
        init(nameTask: String, nameProject: String, timeTask: String, startDate: String, endDate: String, status: String, executor: String) {
            self.nameTask = nameTask
            self.nameProject = nameProject
            self.timeTask = timeTask
            self.startDate = startDate
            self.endDate = endDate
            self.status = status
            self.executor = executor
        }
    }
    
    var tasks: [Task] {
        get {
            if let data = defaults.value(forKey: "tasks") as? Data {
                return try! PropertyListDecoder().decode([Task].self, from: data)
            } else {
                return [Task]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: "tasks")
            }
        }
    }
    
    func saveTask(nameTask: String, nameProject: String, timeTask: String, startDate: String, endDate: String, status: String, executor: String, index: Int?) {
        var existingTasks = tasks
        if let index = index,
           index < existingTasks.count {
            existingTasks[index] = Task(nameTask: nameTask, nameProject: nameProject, timeTask: timeTask, startDate: startDate, endDate: endDate, status: status, executor: executor)
            tasks = existingTasks
        } else {
            let task = Task(nameTask: nameTask, nameProject: nameProject, timeTask: timeTask, startDate: startDate, endDate: endDate, status: status, executor: executor)
            tasks.insert(task, at: 0)
        }
    }
}
