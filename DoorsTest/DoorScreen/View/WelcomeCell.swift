//
//  WelcomeCell.swift
//  DoorsTest
//
//  Created by Macbook Pro 13 on 20.11.2021.
//

import Foundation
import SnapKit
import UIKit

class WelcomeCell: UITableViewCell {
    private let interQRBtn = UIButton(type: .system)
    private let settingsBtn = UIButton()
    private let welcomeLbl = UILabel()
    private let doorImage = UIImageView(image: UIImage(named: "doorImage"))
    private let screenshot = UIImageView(image: UIImage(named: "welcomeScreenshot"))
    var indexPath: IndexPath?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        selectionStyle = .none
        backgroundColor = .white
        
        self.contentView.addSubview(screenshot)
        
        screenshot.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(SizeHelper.screen.width / 1.5)
            make.edges.equalTo(self.contentView)
            make.top.equalToSuperview().offset(SizeHelper.sizeH(40))
        }
    }
}
