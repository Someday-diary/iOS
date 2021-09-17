//
//  FloatingViewReactor.swift
//  diary
//
//  Created by 김부성 on 2021/09/10.
//

import Foundation

import ReactorKit
import RxRelay
import RxFlow

final class FloatingViewReactor: Reactor, Stepper {
    var steps = PublishRelay<Step>()
    
    let initialState: State
    
    enum Action {
        case write
        case updateDiary
    }
    
    enum Mutation {
        case updateDate(Date)
        case updateDiary([RealmDiary])
    }
    
    struct State {
        var selectedDay: Date
        var diaryData: String = String()
        var diaryTags: String = String()
        var createState: Bool = true
    }
    
    let userService: UserServiceType
    let realmService: RealmServiceType
    
    init(date: Date, userService: UserServiceType, realmService: RealmServiceType) {
        self.initialState = State(selectedDay: date)
        
        self.userService = userService
        self.realmService = realmService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .updateDiary:
            return self.readDiary(date: self.currentState.selectedDay).flatMap { result in
                Observable.just(Mutation.updateDiary(result)).catchErrorJustReturn(Mutation.updateDiary([]))
            }
            
        case .write:
            self.steps.accept(DiaryStep.writeIsRequired(self.currentState.selectedDay))
            return Observable.empty()
        }
    }
    
    // Global State
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let eventMutation = userService.event.flatMap { [weak self] event -> Observable<Mutation> in
            guard let `self` = self else { return Observable.empty() }
            
            switch event {
            
            case let .updateDate(newDay):
                return Observable.concat([
                    Observable.just(Mutation.updateDate(newDay)),
                    
                    self.readDiary(date: newDay).flatMap { result in
                        Observable.just(Mutation.updateDiary(result)).catchErrorJustReturn(Mutation.updateDiary([]))
                    }
                ])
                
            }
        }
        
        return Observable.merge(mutation, eventMutation)
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        
        case let .updateDiary(diary):
            if diary.isEmpty {
                state.diaryData = ""
                state.diaryTags = "태그 추가"
                state.createState = true
            } else {
                state.diaryData = diary[0].data
                state.diaryTags = diary[0].tags
                state.createState = false
            }
        
        case let .updateDate(newDay):
            state.selectedDay = newDay
            
        }
        
        return state
    }
}

extension FloatingViewReactor {
    func readDiary(date: Date) -> Observable<[RealmDiary]> {
        self.realmService.read(query: NSPredicate(format: "date CONTAINS %@", date.realmString)).asObservable()
    }
}
