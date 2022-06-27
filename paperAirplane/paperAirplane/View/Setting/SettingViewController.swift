//
//  SettingViewController.swift
//  paperAirplane
//
//  Created by 이건우 on 2022/06/16.
//

import Foundation
import UIKit
import SwiftUI

class SettingViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var settingTableView: UITableView!
    @IBOutlet weak var etcTableView: UITableView!
    
    @IBOutlet weak var centerLine: UIView!
    
    // MARK: - Variables
    let viewModel = SettingViewModel()
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        
        self.view.setGradient(colors: mainGradientColor)
        centerLine.layer.cornerRadius = 2
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.tag = 1
        
        etcTableView.register(MySettingTableViewCell.self, forCellReuseIdentifier: "MySettingTableViewCell")
        etcTableView.delegate = self
        etcTableView.dataSource = self
        etcTableView.tag = 2
    }
    
    // MARK: - Functions
    private func setNavigationBar() {
        title = "설정"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "RIDIBatang", size: 18)!,
            .foregroundColor: myWhiteColor
        ]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain,
            target: self, action: #selector(backButtonTapped)
        )
    }
    
    // MARK: - @objc Functions
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 1:
            return 6
        case 2:
            return 3
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView.tag {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MySettingTableViewCell", for: indexPath) as! MySettingTableViewCell
            if indexPath.row < 4 {
                cell.updateUI(indexPath)
                return cell
            } else {
                cell.updateUI(indexPath)
                return cell
            }
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyEtcSettingTableViewCell", for: indexPath) as! MyEtcSettingTableViewCell
            cell.updateUI(indexPath)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    // 기종의 노치 여부에 따라 설정 셀 크기 조절
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if hasNotch {
            return view.frame.height / 13
        } else {
            return view.frame.height / 12
        }
    }
}
