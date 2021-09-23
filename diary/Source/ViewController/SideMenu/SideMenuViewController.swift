//
//  SideMenuViewController.swift
//  diary
//
//  Created by 김부성 on 2021/08/28.
//

import UIKit
import ReactorKit
import RxViewController

final class SideMenuViewController: BaseViewController, View {
    
    typealias Reactor = SideMenuViewReactor
    
    // MARK: - Constants
    fileprivate struct Metric {
        // Title
        static let titleTop = 40.f
        static let titleBottom = 80.f
        
        // ListButton
        static let listButtonSide = 16.f
        static let listButtonTop = 25.f
        
        // Logout Button
        static let logoutButtonBottom = 30.f
    }
    
    fileprivate struct Font {
        static let titleFont = UIFont.systemFont(ofSize: 32, weight: .ultraLight)
    }
    
    // MARK: - UI
    let titleLabel = UILabel().then {
        $0.text = "오늘 하루"
        $0.font = Font.titleFont
    }
    
    let themeButton = DiarySideMenuListButton().then {
        $0.icon.image = R.image.themeIcon()
        $0.label.text = "테마 설정"
    }
    
    let alarmButton = DiarySideMenuListButton().then {
        $0.icon.image = R.image.alarmIcon()
        $0.label.text = "일기 알람 설정"
    }
    
    let lockButton = DiarySideMenuListButton().then {
        $0.icon.image = R.image.lockIcon()
        $0.label.text = "잠금 설정"
    }
    
    let infoButton = DiarySideMenuListButton().then {
        $0.icon.image = R.image.openSourceIcon()
        $0.label.text = "앱 정보"
    }
    
    let feedbackButton = DiarySideMenuListButton().then {
        $0.icon.image = R.image.feedbackIcon()
        $0.label.text = "사용자 피드백"
    }
    
    let dismissButton = UIBarButtonItem().then {
        $0.image = R.image.dismissButton()
        $0.tintColor = R.color.navigationButtonColor()
    }
    
    let logoutButton = LogoutButton()
    
    // MARK: - Initializing
    init(reactor: Reactor) {
        super.init()
        
        defer {
            self.reactor = reactor
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(self.themeButton)
        self.view.addSubview(self.alarmButton)
        self.view.addSubview(self.lockButton)
        self.view.addSubview(self.infoButton)
        self.view.addSubview(self.feedbackButton)
        self.view.addSubview(self.logoutButton)
        self.navigationItem.rightBarButtonItem = dismissButton
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSafeArea(self.view).offset(Metric.titleTop)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.themeButton.snp.top).offset(-Metric.titleBottom)
        }
        
        self.themeButton.snp.makeConstraints {
            $0.left.equalToSafeArea(self.view).offset(Metric.listButtonSide)
            $0.right.equalToSafeArea(self.view).offset(-Metric.listButtonSide)
        }
        
        self.alarmButton.snp.makeConstraints {
            $0.top.equalTo(self.themeButton.snp.bottom).offset(Metric.listButtonTop)
            $0.left.equalToSafeArea(self.view).offset(Metric.listButtonSide)
            $0.right.equalToSafeArea(self.view).offset(-Metric.listButtonSide)
        }
        
        self.lockButton.snp.makeConstraints {
            $0.top.equalTo(self.alarmButton.snp.bottom).offset(Metric.listButtonTop)
            $0.left.equalToSafeArea(self.view).offset(Metric.listButtonSide)
            $0.right.equalToSafeArea(self.view).offset(-Metric.listButtonSide)
        }
        
        self.infoButton.snp.makeConstraints {
            $0.top.equalTo(self.lockButton.snp.bottom).offset(Metric.listButtonTop)
            $0.left.equalToSafeArea(self.view).offset(Metric.listButtonSide)
            $0.right.equalToSafeArea(self.view).offset(-Metric.listButtonSide)
        }
        
        self.feedbackButton.snp.makeConstraints {
            $0.top.equalTo(self.infoButton.snp.bottom).offset(Metric.listButtonTop)
            $0.left.equalToSafeArea(self.view).offset(Metric.listButtonSide)
            $0.right.equalToSafeArea(self.view).offset(-Metric.listButtonSide)
        }
        
        self.logoutButton.snp.makeConstraints {
            $0.bottom.equalToSafeArea(self.view).offset(-Metric.logoutButtonBottom)
            $0.right.equalToSafeArea(self.view).offset(-Metric.listButtonSide)
            $0.width.equalTo(self.view.frame.width / 2)
        }
    }
    
    // MARK: - Configuring
    func bind(reactor: SideMenuViewReactor) {
        //input
        self.logoutButton.rx.tap.asObservable()
            .map { Reactor.Action.logout }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.dismissButton.rx.tap.asObservable()
            .map { Reactor.Action.dismiss }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        Observable.merge(
            themeButton.rx.tap.map { Reactor.Action.setTheme },
            alarmButton.rx.tap.map { Reactor.Action.setAlarm },
            lockButton.rx.tap.map { Reactor.Action.setLock },
            infoButton.rx.tap.map { Reactor.Action.showInfo },
            feedbackButton.rx.tap.map { Reactor.Action.userFeedBack }
        ).asObservable()
        .bind(to: reactor.action)
        .disposed(by: disposeBag)
        
        self.rx.viewWillDisappear.asObservable()
            .map { _ in Reactor.Action.disappear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

}
