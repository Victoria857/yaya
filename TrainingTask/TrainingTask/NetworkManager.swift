//
//  NetworkManager.swift
//  TrainingTask
//
//  Created by Tishkovskaya, Viktoria on 3.03.22.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func getProjects(completion: @escaping(([BaseProject.Project]) -> Void)) {
        completion(BaseProject.shared.projects)
    }
    
    func getTasks(completion: @escaping(([BaseTask.Task]) -> Void)) {
        completion(BaseTask.shared.tasks)
    }
    
    func getStaffs(completion: @escaping(([BaseStaff.Staff]) -> Void)) {
        completion(BaseStaff.shared.staffs)
    }

}
