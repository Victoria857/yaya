//
//  Project.swift
//  TrainingTask
//
//  Created by Tishkovskaya, Viktoria on 23.02.22.
//

import Foundation

class BaseProject {
    let defaults = UserDefaults.standard
    static let shared = BaseProject()
    
    
    // MARK: class Project
    class Project: Codable {
    var nameProject: String!
    var descriptionProject: String!
    
//        private init() {}
    
        init(nameProject: String, descriptionProject: String) {
        self.nameProject = nameProject
        self.descriptionProject = descriptionProject
        }
    }
    
    var projects: [Project] {
        get {
            if let data = defaults.value(forKey: "projects") as? Data {
                return try! PropertyListDecoder().decode([Project].self, from: data)
            } else {
                return [Project]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: "projects")
            }
        }
    }
    
    func saveProject(nameProject: String, descriptionProject: String, index: Int?) {
        var existingProjects = projects
        if let index = index,
           index < existingProjects.count {
            existingProjects[index] = Project(
                nameProject: nameProject,
                descriptionProject: descriptionProject)
            projects = existingProjects
        } else {
            let project = Project(nameProject: nameProject, descriptionProject: descriptionProject)
            projects.insert(project, at: 0)
        }
    }
    
  
    func removeSelectItem(array: [BaseProject.Project]) {
        defaults.set(array, forKey: "projects")
        
    }
    
    func showListOfProjects() {
        defaults.value(forKey: "projects")
    }
}
