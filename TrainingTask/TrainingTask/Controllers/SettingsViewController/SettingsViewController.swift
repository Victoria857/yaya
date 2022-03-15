//
//  SettingsViewController.swift
//  TrainingTask
//
//  Created by Tishkovskaya, Viktoria on 22.02.22.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var urlServerTextField: UITextField!
    @IBOutlet weak var maxQuantityTextField: UITextField!
    @IBOutlet weak var quantityBetweenDateTextField: UITextField!
    
    let userDef = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        urlServerTextField.text = userDef.string(forKey: "urlServer")
        maxQuantityTextField.text = userDef.string(forKey: "maxQuantity")
        quantityBetweenDateTextField.text = userDef.string(forKey: "quantityBetweenDate")
        
    }

    @IBAction func didTapSaveButton(_ sender: Any) {
        guard let url = urlServerTextField.text, !url.isEmpty, let maxQuantity = maxQuantityTextField.text, !maxQuantity.isEmpty, let quantityBetweenDate = quantityBetweenDateTextField.text, !quantityBetweenDate.isEmpty else { return }
        userDef.setValue(urlServerTextField.text, forKey: "urlServer")
        userDef.setValue(maxQuantityTextField.text, forKey: "maxQuantity")
        userDef.setValue(quantityBetweenDateTextField.text, forKey: "quantityBetweenDate")
        
    }
    


}
