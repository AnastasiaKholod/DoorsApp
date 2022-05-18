    //
    //  DoorCell.swift
    //  DoorsTest
    //
    //  Created by Macbook Pro 13 on 20.11.2021.
    //

import Foundation
import SnapKit
import UIKit

class DoorTableViewCell: UITableViewCell {
    private let mainCellView: UIView = {
        let obj = UIView()
        obj.layer.cornerRadius = 15
        obj.layer.borderColor = UIColor.lightGray.cgColor
        obj.layer.borderWidth = 0.5
        return obj
    }()

    private let leftIconImageView: UIImageView = {
        let obj = UIImageView()
        return obj
    }()

    private let rightIconImageView = UIImageView()
    
    private let doorTitleLbl: UILabel = {
        let obj = UILabel()
        obj.text = ""
        obj.font = UIFont.Roboto.regular(size: SizeHelper.sizeW(18)) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
        obj.textColor = .black
        obj.textAlignment = .left
        obj.adjustsFontSizeToFitWidth = true
        obj.minimumScaleFactor = 0.5
        obj.isHidden = false
        return obj
    }()

    private let roomTypeLbl: UILabel = {
        let obj = UILabel()
        obj.text = ""
        obj.font = UIFont.Roboto.regular(size: SizeHelper.sizeW(18)) ?? UIFont.systemFont(ofSize: 14, weight: .regular)
        obj.textColor = .black
        obj.textAlignment = .left
        obj.adjustsFontSizeToFitWidth = true
        obj.minimumScaleFactor = 0.5
        obj.isHidden = false
        return obj
    }()

    private let lockStatusLabel: UILabel = {
        let obj = UILabel()
        obj.text = ""
        obj.font = UIFont.Roboto.regular(size: SizeHelper.sizeW(18)) ?? UIFont.systemFont(ofSize: 15, weight: .regular)
        obj.textColor = .blue
        obj.textAlignment = .left
        obj.adjustsFontSizeToFitWidth = true
        obj.minimumScaleFactor = 0.5
        obj.isHidden = false
        obj.isUserInteractionEnabled = true
        return obj
    }()
    
    var doorModelItem: DoorModelItem? {
        didSet {
            guard let doorModelItem = doorModelItem else {
                return
            }
            
            handleValues(model: doorModelItem)
        }
    }

    private var indexPath: IndexPath?

    private let doorImage = UIImageView(image: UIImage(named: "doorImage"))

    var doorLockStatus: LockStatus = .locked {
        didSet {
            leftIconImageView.image = UIImage(named: doorLockStatus.leftIconImageName)
            rightIconImageView.image = UIImage(named: doorLockStatus.rightIconImageName)
            lockStatusLabel.text = doorLockStatus.lockStatusText
        }
    }

    var lockDoorTapped: ((IndexPath)->())?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @objc func lockStatusLabelTapped(_ sender: UITapGestureRecognizer) {
        self.lockDoorTapped?(indexPath!)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        selectionStyle = .none
        
        contentView.addSubview(mainCellView)
        mainCellView.addSubview(leftIconImageView)
        mainCellView.addSubview(rightIconImageView)
        mainCellView.addSubview(doorTitleLbl)
        mainCellView.addSubview(roomTypeLbl)
        mainCellView.addSubview(lockStatusLabel)

        mainCellView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(SizeHelper.sizeW(12))
            make.left.equalToSuperview().inset(SizeHelper.sizeW(12))
            make.top.equalToSuperview().inset(SizeHelper.sizeH(12))
            make.bottom.equalToSuperview()
        }

        leftIconImageView.snp.makeConstraints { make in
            make.size.equalTo(41)
            make.top.equalToSuperview().offset(SizeHelper.sizeH(19))
            make.leading.equalToSuperview().offset(SizeHelper.sizeH(23))
        }

        rightIconImageView.snp.makeConstraints { make in
            make.size.equalTo(41)
            make.top.equalToSuperview().offset(SizeHelper.sizeH(19))
            make.trailing.equalToSuperview().offset(SizeHelper.sizeH(-16))
        }

        doorTitleLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(SizeHelper.sizeH(22))
            make.leading.equalTo(leftIconImageView.snp.trailing).offset(SizeHelper.sizeH(15))
        }

        roomTypeLbl.snp.makeConstraints { make in
            make.top.equalTo(doorTitleLbl.snp.bottom).offset(SizeHelper.sizeH(2))
            make.leading.equalTo(leftIconImageView.snp.trailing).offset(SizeHelper.sizeW(15))
        }
        
        lockStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(roomTypeLbl.snp.bottom).offset(SizeHelper.sizeH(31))
            make.centerX.equalTo(contentView.snp.centerX)
            make.bottom.equalToSuperview().offset(SizeHelper.sizeH(-15))
        }
        
        let lockStatusLabelTapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                         action: #selector(self.lockStatusLabelTapped))
        lockStatusLabel.addGestureRecognizer(lockStatusLabelTapGestureRecognizer)
    }
}

//MARK: - helpers and handlers
extension DoorTableViewCell {
    private func handleValues(model: DoorModelItem) {
        doorTitleLbl.text = model.doorType?.rawValue
        roomTypeLbl.text = model.roomType?.rawValue
        doorLockStatus = model.doorLocked == true ? .locked : .unlocked
    }
    
    enum LockStatus: String {
        case locked
        case unlocked
        case unlocking
        
        var leftIconImageName: String {
            switch self {
            case .locked:
                return "left_locked_icon"
            case .unlocked:
                return "left_unlocked_icon"
            case .unlocking:
                return "left_unlocking_icon"
            }
        }
        
        var rightIconImageName: String {
            switch self {
            case .locked:
                return "right_locked_icon"
            case .unlocked:
                return "right_unlocked_icon"
            case .unlocking:
                return "right_unlocking"
            }
        }
        
        var lockStatusText: String {
            switch self {
            case .locked:
                return "Locked"
            case .unlocked:
                return "Unlocked"
            case .unlocking:
                return "Unlocking"
            }
        }
    }
}

