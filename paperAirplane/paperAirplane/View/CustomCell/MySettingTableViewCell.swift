//
//  MySettingTableViewCell.swift
//  paperAirplane
//
//  Created by 이건우 on 2022/06/19.
//

import UIKit

class MySettingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var myTextLabel: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    let title = [
        "암호 잠금",
        "생체 인증",
        "알림",
        "프로필",
        "글자 스타일",
        "배경"
    ]
    
    func updateUI(_ indexPath: IndexPath) {
        `switch`.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        myTextLabel?.text = title[indexPath.row]
        
        switch indexPath.row {
        case 0...2:
            icon.image = UIImage(named: "kakao_login")
            `switch`.isHidden = false
            arrowImageView.isHidden = true
        case 3...6:
            icon.image = UIImage(named: "google_login")
            `switch`.isHidden = true
            arrowImageView.isHidden = false
        default:
            return
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
