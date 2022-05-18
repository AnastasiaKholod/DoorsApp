//
//
//
//  DoorScreenViewController.swift
//	DoorsTestTask
//

import UIKit

class DoorScreenViewController: UIViewController {
    
    let model = DoorService()
    private var mainView = DoorScreenView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    private func initViewController() {
        // TODO: add progress Bar
        model.requestDoorList()
        model.delegate = self
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(WelcomeCell.self, forCellReuseIdentifier: "welcomeCell")
        mainView.tableView.register(DoorTableViewCell.self, forCellReuseIdentifier: "doorCell")
    }
}

// MARK: - Unlock Door method
extension DoorScreenViewController {
    func unlockDoor (indexPath: IndexPath) {
        if let currentCell = mainView.tableView.cellForRow(at: indexPath)! as? DoorTableViewCell {
            guard currentCell.doorLockStatus == .locked else{
                return
            }
            model.unlockDoor(id: mainView.doorsArray[indexPath.row-1].doorId!, indexPath: indexPath)
            
            currentCell.doorLockStatus = .unlocking
            
            model.onLockStatusChanged = { [weak self] (status, indexPath) in
                guard let self = self else {return}
                
                let cell = self.mainView.tableView.cellForRow(at: indexPath) as? DoorTableViewCell
                
                switch status {
                case true:
                    cell?.doorLockStatus = .locked
                case false:
                    cell?.doorLockStatus = .unlocked
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension DoorScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // +1 because we need place for 0 cell => WelcomeCell
        return mainView.doorsArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cellID = "welcomeCell"
            let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        cellID, for: indexPath) as? WelcomeCell
            return cell!
            
        default:
            let row = indexPath.row
            let model = mainView.doorsArray[indexPath.item-1]
            let cellID = "doorCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        cellID, for: indexPath) as? DoorTableViewCell
            cell?.doorModelItem = model
            
            cell?.lockDoorTapped = { [weak self] nothing in
                self?.unlockDoor(indexPath: indexPath)
            }
            
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        unlockDoor(indexPath: indexPath)
    }
}

// MARK: - DoorDelegate
extension DoorScreenViewController: DoorServiceDelegate {
    
    func didFailDataUpdateWithError(error: Error) {
    }
    
    func didRecieveDoors(list: [DoorModelItem]) {
        mainView.doorsArray = list
    }
}
