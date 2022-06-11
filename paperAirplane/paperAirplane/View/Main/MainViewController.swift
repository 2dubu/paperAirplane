//
//  MainViewController.swift
//  paperAirplane
//
//  Created by 이건우 on 2022/05/21.
//

import UIKit
import Lottie

class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    // 사용자 이름, 보유 연필 수 표시 레이블
    @IBOutlet weak var mainInfoTextLabel: UILabel!
    
    // 로티 뷰
    @IBOutlet weak var lottieView: AnimationView!
    
    // 종이비행기 날리러 가기 버튼
    @IBOutlet weak var sendAirplaneButton: UIButton!
    
    // MARK: - Variables
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setGradient(colors: mainGradientColor)
        
        setElements()
    }
    
    // MARK: - IBActions
    
    
    // MARK: - Functions
    private func setElements() {
        setMainInfoTextLabel()
        setLottieView()
        setSendAirPlaneButton()
    }
    
    /// 사용자 이름, 보유 연필 수 표시 레이블 세팅
    /// 텍스트, 텍스트 컬러, 줄 간격
    private func setMainInfoTextLabel() {
        mainInfoTextLabel.textColor = .white
        mainInfoTextLabel.setTextWithLineHeight(text: "바비인형 님이\n현재 보유하고 있는 연필은\n4개입니다.",
                                                lineHeight: 32)
    }
    
    /// lottieView 설정
    private func setLottieView() {
        lottieView.loopMode = .loop
        lottieView.play()
    }
    
    /// 종이비행기 날리러 가기 버튼 세팅
    /// 배경색, 둥글기, 그림자
    private func setSendAirPlaneButton() {
        sendAirplaneButton.backgroundColor = buttonBackgroundColor
        sendAirplaneButton.layer.cornerRadius = 16
        
        sendAirplaneButton.layer.shadowOffset = .zero
        sendAirplaneButton.layer.shadowRadius = 8
        sendAirplaneButton.layer.shadowOpacity = 1.0
        sendAirplaneButton.layer.shadowColor = buttonBackgroundColor.cgColor
        
    }
    
}

