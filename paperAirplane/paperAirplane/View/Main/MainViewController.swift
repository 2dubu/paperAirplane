//
//  MainViewController.swift
//  paperAirplane
//
//  Created by 이건우 on 2022/05/21.
//

import UIKit
import Lottie
import AVFoundation

class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    // 왼쪽 네비게이션 BGM 버튼
    @IBOutlet weak var musicButton: UIBarButtonItem!
    
    // 사용자 이름, 보유 연필 수 표시 레이블
    @IBOutlet weak var mainInfoTextLabel: UILabel!
    
    // 로티 뷰
    @IBOutlet weak var lottieView: AnimationView!
    
    // 나에게 온 종이비행기 확인하기 버튼
    @IBOutlet weak var checkPaperAirplaneButton: UIButton!
    
    // 종이비행기 날리러 가기 버튼
    @IBOutlet weak var sendPaperAirplaneButton: UIButton!
    
    // MARK: - Variables
    let myUserDefaults = UserDefaults.standard
    
    var audioPlayer: AVAudioPlayer?
    
    let bgmUrl = Bundle.main.url(forResource: "BGM", withExtension: "mp3")
    var bgmIsOn = Bool()
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setGradient(colors: mainGradientColor)
        
        // userDefault값 가져온 후 bgm 재생
        if let bgm = myUserDefaults.value(forKey: "bgmIsOn") {
            bgmIsOn = bgm as! Bool
        } else {
            bgmIsOn = true
        }
        
        setElements()
        setAudioPlayer()
    }
    
    // MARK: - IBActions
    @IBAction func musicButtonTapped(_ sender: Any) {
        if audioPlayer?.isPlaying == true {
            myUserDefaults.set(false, forKey: "bgmIsOn")
            musicButton.image = UIImage(named: "music_off")
            audioPlayer?.stop()
        } else {
            myUserDefaults.set(true, forKey: "bgmIsOn")
            musicButton.image = UIImage(named: "music")
            audioPlayer?.play()
        }
    }
    
    @IBAction func settingButtonTapped(_ sender: Any) {
        self.navigationController?.pushViewController(getVC("SettingViewController"), animated: true)
    }
    
    @IBAction func checkPaperAirplaneButtonTapped(_ sender: Any) {
    }
    
    @IBAction func sendPaperAirplaneButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Functions
    private func setElements() {
        setMainInfoTextLabel()
        setLottieView()
        setButtons([
            checkPaperAirplaneButton,
            sendPaperAirplaneButton
        ])
    }
    
    /// 사용자 이름, 보유 연필 수 표시 레이블 세팅
    /// 텍스트, 텍스트 컬러, 줄 간격
    private func setMainInfoTextLabel() {
        mainInfoTextLabel.textColor = myWhiteColor
        mainInfoTextLabel.setTextWithLineHeight(text: "바비인형 님이\n현재 보유하고 있는 연필은\n4개입니다.",
                                                lineHeight: 32)
    }
    
    /// lottieView 설정
    private func setLottieView() {
        lottieView.loopMode = .loop
        lottieView.play()
    }
    
    /// 버튼 기본 디자인 세팅
    /// 배경색, 둥글기, 그림자
    private func setButtons(_ buttons: [UIButton]) {
        
        for i in 0..<buttons.count {
            buttons[i].backgroundColor = myWhiteColor
            buttons[i].layer.cornerRadius = 16
            
            buttons[i].layer.shadowOffset = .zero
            buttons[i].layer.shadowRadius = 8
            buttons[i].layer.shadowOpacity = 1.0
            buttons[i].layer.shadowColor = myWhiteColor.cgColor
        }
    }
    
    /// 오디오 플레이어
    private func setAudioPlayer() {
        if let url = bgmUrl {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.prepareToPlay()
            } catch {
                print(error)
            }
        }
        
        if bgmIsOn == false {
            musicButton.image = UIImage(named: "music_off")
        } else {
            musicButton.image = UIImage(named: "music")
            audioPlayer?.play()
        }
    }
    
}

