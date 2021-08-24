//
//  MainViewController.swift
//  diary
//
//  Created by 김부성 on 2021/08/20.
//

import UIKit
import ReactorKit
import FSCalendar

final class MainViewController: BaseViewController, View {
    
    typealias Reactor = MainViewReactor
    
    // MARK: Constants
    struct Font {
        static let calendarTitle = UIFont.systemFont(ofSize: 24)
    }
    
    // MARK: UI
    let calendarView = DiaryCalendar()
    let label = UILabel()
    
    // MARK: Initializing
    init(reactor: Reactor) {
        super.init()
        defer { self.reactor = reactor }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupLayout() {
        self.view.addSubview(calendarView)
        self.view.addSubview(label)
    }
    
    override func makeConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        self.calendarView.snp.makeConstraints {
            $0.bottom.equalTo(safeArea.snp.centerY)
            $0.top.equalTo(safeArea.snp.top)
            $0.left.equalTo(safeArea.snp.left).offset(26)
            $0.right.equalTo(safeArea.snp.right).offset(-26)
        }
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        self.calendarView.calendar.reloadData()
        self.calendarView.calendar.calendarHeaderView.reloadData()
    }
    
    // MARK: Configuring
    
    func bind(reactor: MainViewReactor) {
        // Input
        self.calendarView.calendar.rx.didSelect.asObservable()
            .map { Reactor.Action.setDay($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // Output
        reactor.state
            .map { "\($0.selectedDay)" }
            .distinctUntilChanged()
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        // View
        self.calendarView.calendar.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }

}

extension MainViewController: FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let dateFormatter = DateFormatter().then {
            $0.dateFormat = "yyyy-MM-dd"
        }
        
        let newDate = date.addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT(for: date)))
        
        let somedays = ["2021-08-03",
                        "2021-08-06",
                        "2021-08-12",
                        "2021-08-25"]
        let dateString : String = dateFormatter.string(from: newDate)
        
        if somedays.contains(dateString) { return R.color.mainColor() }
        return nil
    }
}