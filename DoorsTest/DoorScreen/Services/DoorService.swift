//
//  DoorLockStatusModel.swift
//  DoorsTest
//
//  Created by Macbook Pro 13 on 20.11.2021.
//

import Foundation

protocol DoorServiceDelegate: NSObjectProtocol {
    func didRecieveDoors(list: [DoorModelItem])
    func didFailDataUpdateWithError(error: Error)
}

class DoorService {
    weak var delegate: DoorServiceDelegate?
    var doorItems = [DoorModelItem]() {
        didSet {
            delegate?.didRecieveDoors(list: doorItems)
        }
    }
    
    var onLockStatusChanged: ((_ isLocked: Bool, _ indexPath: IndexPath)->())?

    func requestDoorList() {
        var error: Error?
        var response: [DoorModelItem] = []

        for index in 0...3 {
            let modelItem = DoorModelItem(doorLocked: true, doorType: .frontDoor, roomType: .home, id: index)
            response.append(modelItem)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
//            guard let _ = error else {
//                self?.delegate?.didFailDataUpdateWithError(error: error!)
//                return
//            }
            
            self?.doorItems = response
        }
    }

    func unlockDoor(id: Int, indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self] in
            self?.onLockStatusChanged?(false, indexPath)
            self?.lockDoor(id: id, indexPath: indexPath)
        }
    }

    func lockDoor(id: Int, indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self] in
            self?.onLockStatusChanged?(true, indexPath)
            print("id \(id)")
        }
    }
}


