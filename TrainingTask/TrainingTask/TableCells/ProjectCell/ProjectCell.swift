//
//  ProjectCell.swift
//  TrainingTask
//
//  Created by Tishkovskaya, Viktoria on 22.02.22.
//

import UIKit

class ProjectCell: UITableViewCell {

    @IBOutlet weak var nameProjectLabel: UILabel!
    @IBOutlet weak var descriptionProjectLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    func setupCell(project: BaseProject.Project) {
        nameProjectLabel.text = project.nameProject
        descriptionProjectLabel.text = project.descriptionProject
    }
}
