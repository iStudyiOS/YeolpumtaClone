//
//  TimerController.swift
//  YeolpumtaClone
//
//  Created by minii on 2021/07/25.
//

import UIKit
import SnapKit

class TimerController: UIViewController {
    //MARK: - Properties
    
    var timer = Timer()
    var count:Int = 0
    var timerCounting: Bool = false
    
    let DidDismissTimerController: Notification.Name = Notification.Name("DidDismissTimerController")
    
    private let totalTimerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .systemGray
        label.text = "총 공부시간"
        return label
    }()
    
    private let totalTimerTime: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 44, weight: .medium)
        label.textColor = .white
        label.text = "00:00:00"
        return label
    }()
    
    private let objectTimerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemGray
        label.text = "과목"
        return label
    }()
    
    private let objectTimerTime: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        label.text = "00:00:00"
        return label
    }()
    
    private let recentTimerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemGray
        label.text = "현재 집중 시간"
        return label
    }()
    
    private let recentTimerTime: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        label.text = "00:00:00"
        return label
    }()
    
    let button: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        bt.imageView?.snp.makeConstraints({
            $0.width.height.equalTo(60)
        })
        bt.backgroundColor = .black
        bt.tintColor = .systemGray
        bt.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return bt
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        setUpUI()
        setTimer()
    }
    
    // MARK: - Helpers
    
    func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
    }
    
    func setUpUI() {
        view.backgroundColor = .black

        // timerTime의 width과 height을 지정한 이유는, 지정하지 않을 시 타이머 시간에 따라 크기가 변동되기 때문입니다.
        let totalStack = UIStackView(arrangedSubviews: [totalTimerLabel, totalTimerTime])
        totalTimerTime.snp.makeConstraints {
            $0.width.equalTo(188)
            $0.height.equalTo(50)
        }
        totalStack.axis = .vertical
        totalStack.alignment = .center

        let objectStack = UIStackView(arrangedSubviews: [objectTimerLabel, objectTimerTime])
        objectTimerTime.snp.makeConstraints {
            $0.width.equalTo(86)
            $0.height.equalTo(26)
        }
        objectStack.axis = .vertical
        objectStack.alignment = .center

        let recentStack = UIStackView(arrangedSubviews: [recentTimerLabel, recentTimerTime])
        recentTimerTime.snp.makeConstraints {
            $0.width.equalTo(86)
            $0.height.equalTo(26)
        }
        recentStack.axis = .vertical
        recentStack.alignment = .center

        let detailStack = UIStackView(arrangedSubviews: [objectStack, recentStack])
        detailStack.axis = .horizontal
        detailStack.spacing = 12

        let allStack = UIStackView(arrangedSubviews: [totalStack, detailStack])
        allStack.axis = .vertical
        allStack.alignment = .center
        allStack.spacing = 20

        view.addSubview(allStack)
        allStack.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(view.bounds.height / 5)
        }

        view.addSubview(button)
        button.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(allStack.snp.bottom).offset(160)
        }
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600)/60, ((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String{
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += ":"
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    // MARK: - Actions
    
    @objc func timerCounter() -> Void {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        totalTimerTime.text = timeString
        objectTimerTime.text = timeString
        recentTimerTime.text = timeString
    }
    
    @objc func didTapButton() {

        NotificationCenter.default.post(name: DidDismissTimerController, object: nil)
        self.dismiss(animated: true, completion: nil)
    }
}
