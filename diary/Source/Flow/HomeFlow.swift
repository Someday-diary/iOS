//
//  HomeFlow.swift
//  diary
//
//  Created by 김부성 on 2021/08/27.
//

import UIKit
import RxFlow
import FloatingPanel
import SideMenu

class HomeFlow: Flow {
    
    private let services: AppServices
    
    var root: Presentable {
        return self.rootViewController
    }
    
    let navigationAppearance = UINavigationBarAppearance().then {
        $0.configureWithTransparentBackground()
    }
    
    private lazy var rootViewController = UINavigationController().then {
        $0.navigationBar.standardAppearance = navigationAppearance
    }
    
    init(_ services: AppServices) {
        self.services = services
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DiaryStep else { return .none }
        
        switch step {
        case .mainIsRequired:
            return navigateToMain()
            
        case let .floatingPanelIsRequird(date):
            return presentFloatingPanel(date: date)
            
        case let .sideMenuIsRequired(date):
            return navigateToSideMenu(date: date)
            
        case let .writeIsRequired(date):
            return navigateToWrite(date)
            
        case .splashIsRequired:
            return .end(forwardToParentFlowWithStep: DiaryStep.splashIsRequired)
            
        case .dismiss:
            self.rootViewController.dismiss(animated: true, completion: nil)
            return .none
            
        case .popViewController:
            self.rootViewController.popViewController(animated: true)
            return .none
            
        default:
            return .none
        }
    }
    
    
}

extension HomeFlow: FloatingPanelControllerDelegate {
    
    private func navigateToMain() -> FlowContributors {
        let reactor = MainViewReactor(userService: services.userService, realmService: services.realmService)
        let viewController = MainViewController(reactor: reactor)
        
        self.rootViewController.pushViewController(viewController, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
    
    private func presentFloatingPanel(date: Date) -> FlowContributors {
        let reactor = FloatingViewReactor(date: date, userService: services.userService, realmService: services.realmService)
        let fpc = FloatingPanelController().then {
            $0.set(contentViewController: FloatingViewController(reactor: reactor))
            $0.layout = CustomFloatingPanelLayout()
            $0.surfaceView.appearance.cornerRadius = 15
            $0.delegate = self
        }
        
        self.rootViewController.present(fpc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: fpc, withNextStepper: reactor))
    }
    
    private func navigateToWrite(_ date: Date) -> FlowContributors {
        let reactor = WriteViewReactor(date: date)
        let viewController = WriteViewController(reactor: reactor)
        
        self.rootViewController.dismiss(animated: true)
        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: reactor))
    }
    
    private func navigateToSideMenu(date: Date) -> FlowContributors {
        let reactor = SideMenuViewReactor(date: date)
        let viewController = SideMenuViewController(reactor: reactor)
        let sideMenuNavController = SideMenuNavigationController(rootViewController: viewController).then {
            $0.leftSide = true
            $0.presentationStyle = .menuSlideIn
            $0.presentationStyle.presentingEndAlpha = 0.6
            $0.menuWidth = 280
            $0.navigationBar.standardAppearance = navigationAppearance
        }
        
        self.rootViewController.dismiss(animated: true)
        self.rootViewController.present(sideMenuNavController, animated: true, completion: nil)
        return .one(flowContributor: .contribute(withNextPresentable: sideMenuNavController, withNextStepper: reactor))
    }
    
    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
        fpc.surfaceView.theme.backgroundColor = fpc.state == .tip ? themed { $0.subColor } : themed { $0.backgroundColor }
    }
}
