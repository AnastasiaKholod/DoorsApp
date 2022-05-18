//
//
//
//  DoorScreenView
//	DoorsTestTask
//

import UIKit

class DoorScreenView: UIView {
    let tableView: UITableView = {
        let obj = UITableView()
        obj.estimatedRowHeight = 300.0
        obj.rowHeight = UITableView.automaticDimension
        obj.separatorStyle = .none
        return obj
    }()
    
    var doorsArray: [DoorModelItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Initializators
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Functions

    private func setup() {
        addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

