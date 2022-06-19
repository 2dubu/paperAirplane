//
//  MyEtcSettingTableViewCell.swift
//  paperAirplane
//
//  Created by 이건우 on 2022/06/19.
//

import UIKit

class MyEtcSettingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var myTextLabel: UILabel!
    
    let title = [
        "앱 평가하기",
        "문의 및 의견 남기기",
        "앱 버전 1.0.0"
    ]
    
    func updateUI(_ indexPath: IndexPath) {
        icon.image = UIImage(named: "apple_login")
        myTextLabel?.text = title[indexPath.row]
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
