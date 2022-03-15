//
//  BaseStaff.swift
//  TrainingTask
//
//  Created by Tishkovskaya, Viktoria on 3.03.22.
//

import Foundation

class BaseStaff {
    
    let defaults = UserDefaults.standard
    static let shared = BaseStaff()
    
    class Staff: Codable {
        var nameStaff: String!
        var surnameStaff: String!
        var patronymicStaff: String!
        var positionStaff: String!
        
        private init() {}
        
        init(nameStaff: String, surnameStaff: String, patronymicStaff: String, employeePosition: String) {
            self.nameStaff = nameStaff
            self.surnameStaff = surnameStaff
            self.patronymicStaff = patronymicStaff
            self.positionStaff = employeePosition
        }
       
    }
    
    var staffs: [Staff] {
        get {
            if let data = defaults.value(forKey: "staffs") as? Data {
                return try! PropertyListDecoder().decode([Staff].self, from: data)
            } else {
                return [Staff]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: "staffs")
            }
        }
    }
    
    func saveStaff(nameStaff: String, surnameStaff: String, patronymicStaff: String, employeePosition: String, index: Int?) {
        var existingStaffs = staffs
        if let index = index,
           index < existingStaffs.count {
            existingStaffs[index] = Staff(nameStaff: nameStaff, surnameStaff: surnameStaff, patronymicStaff: patronymicStaff, employeePosition: employeePosition)
            staffs = existingStaffs
        } else {
            let staff = Staff(nameStaff: nameStaff, surnameStaff: surnameStaff, patronymicStaff: patronymicStaff, employeePosition: employeePosition)
            staffs.insert(staff, at: 0)
        }
        
    }
}
