//
//  LockViewReactor.swift
//  diary
//
//  Created by 김부성 on 2021/11/09.
//

import Foundation

import ReactorKit
import RxRelay
import RxFlow

final class LockViewReactor: Reactor, Stepper {
    
    var steps: PublishRelay<Step> = PublishRelay<Step>()
    
    let initialState: State
    
    enum Action {
        case changeLock(Bool)
        case changeBio(Bool)
        case changePasscode
        case refresh
    }
    
    enum Mutation {
        case changeStates
    }
    
    struct State {
        var lockIsOn: Bool = UserDefaults.standard.bool(forKey: "passcode")
        var bioIsOn: Bool = UserDefaults.standard.bool(forKey: "bioPasscode")
    }
    
    fileprivate let authService: AuthServiceType
    
    init(authService: AuthServiceType) {
        self.authService = authService
        
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .changeLock(isOn):
            if isOn {
                self.steps.accept(DiaryStep.passcodeIsRequired(.create))
            } else {
                self.authService.removePasscode()
            }
            return Observable.just(Mutation.changeStates)
        
        case let .changeBio(isOn):
            if isOn {
                self.authService.setBioPasscode()
            } else {
                self.authService.removeBioPasscode()
            }
        
            return Observable.just(Mutation.changeStates)
            
        case .changePasscode:
            self.steps.accept(DiaryStep.passcodeIsRequired(.update))
            return Observable.empty()
            
        case .refresh:
            return Observable.just(Mutation.changeStates)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .changeStates:
            state.lockIsOn = UserDefaults.standard.bool(forKey: "passcode")
            state.bioIsOn = UserDefaults.standard.bool(forKey: "bioPasscode")
        }
        
        return state
    }
}

