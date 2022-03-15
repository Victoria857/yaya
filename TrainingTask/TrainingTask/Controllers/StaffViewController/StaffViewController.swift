//
//  StaffViewController.swift
//  TrainingTask
//
//  Created by Tishkovskaya, Viktoria on 22.02.22.


import UIKit

protocol SendDataStaffDelegate: AnyObject {
    func sendDataStaff(staff: BaseStaff.Staff)
}

class StaffViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! 
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var staffs: [BaseStaff.Staff] = []
    
    weak var delegateStaff: SendDataStaffDelegate?
    var select: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        let refreshItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRefreshButton))
       
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.setRightBarButtonItems([addItem, refreshItem], animated: true)
        let nib = UINib(nibName: String(describing: StaffCell.self), bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: String(describing: StaffCell.self))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        spinner.startAnimating()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NetworkManager.shared.getStaffs(completion: getStaffsData)
    }
    
    func getStaffsData(staffs: [BaseStaff.Staff]) {
        self.staffs = staffs
        spinner.stopAnimating()
        self.tableView.reloadData()
    }
    
    @objc func didTapAddButton() {
        let controller = NewStaffViewController(nibName: String(describing: NewStaffViewController.self), bundle: nil)
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }

    
    @objc func didTapRefreshButton() {
        spinner.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            NetworkManager.shared.getStaffs { staffs in
                self.staffs = staffs
                self.tableView.reloadData()
                self.spinner.stopAnimating()
            }
        }
    }
}

extension StaffViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return staffs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StaffCell.self), for: indexPath)
        guard let arrayCell = cell as? StaffCell else { return cell }
        arrayCell.setupCell(staff: staffs[indexPath.row])
        return arrayCell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            spinner.startAnimating()
            tableView.beginUpdates()
            staffs.remove(at: indexPath.row)
            BaseStaff.shared.staffs.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            let newArray = UserDefaults.standard.value(forKey: "staffs")
            UserDefaults.standard.set(newArray, forKey: "staffs")
            tableView.endUpdates()
            spinner.stopAnimating()
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        spinner.startAnimating()
        if select == true {
            delegateStaff?.sendDataStaff(staff: staffs[indexPath.row])
            self.navigationController?.popViewController(animated: true)
        } else {
            let editVC = NewStaffViewController(nibName: String(describing: NewStaffViewController.self), bundle: nil)
            editVC.delegate = self
            editVC.staffName = staffs[indexPath.row].nameStaff
            editVC.staffSurname = staffs[indexPath.row].surnameStaff
            editVC.staffPatronymic = staffs[indexPath.row].patronymicStaff
            editVC.staffPosition = staffs[indexPath.row].positionStaff
            editVC.staffIndex = indexPath.row
            spinner.stopAnimating()
            navigationController?.pushViewController(editVC, animated: true)
        }
        
    }

    
}
