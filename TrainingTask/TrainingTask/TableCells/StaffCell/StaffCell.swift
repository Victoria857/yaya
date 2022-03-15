//
//  StaffCell.swift
//  TrainingTask
//
//  Created by Tishkovskaya, Viktoria on 22.02.22.
//

import UIKit

class StaffCell: UITableViewCell {

    @IBOutlet weak var nameStaffLabel: UILabel!
    @IBOutlet weak var surnameStaffLabel: UILabel!
    @IBOutlet weak var patronymicStaffLabel: UILabel!
    @IBOutlet weak var positionStaffLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(staff: BaseStaff.Staff) {
        nameStaffLabel.text = staff.nameStaff
        surnameStaffLabel.text = staff.surnameStaff
        patronymicStaffLabel.text = staff.patronymicStaff
        positionStaffLabel.text = staff.positionStaff
    }
    
}
