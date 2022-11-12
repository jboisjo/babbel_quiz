//
//  AppRouter.swift
//  jboisjoli-babbel
//
//  Created by Jay Boisjoli on 2022-11-11.
//

import Foundation
import UIKit

protocol AppRouterProtocol {
    var navigationController: UINavigationController { get set }

    func openOverview()
}

class AppRouter: AppRouterProtocol {
    // MARK: Properties
    var navigationController: UINavigationController

    // MARK: Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func openOverview() {
        let controllerOverview = createOverview()
        transitionTo(controllerOverview, showNavBar: true)
    }
}

extension AppRouter: OverviewPresenterDelegate {}

// MARK: - Private extensions/methods
private extension AppRouter {
    func createOverview() -> UIViewController {
        let overviewController = OverviewController()
        let presenter = OverviewPresenter(controller: overviewController,
                                          delegate: self)
        overviewController.presenter = presenter

        return overviewController
    }
    
    func transitionTo(_ controller: UIViewController, showNavBar: Bool) {
        navigationController.pushViewController(controller, animated: true)
        navigationController.isNavigationBarHidden = !showNavBar

        /// Disabling the bottom border
        navigationController.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController.navigationBar.shadowImage = UIImage()
        
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:
                                                                    UIColor.white]
        navigationController.navigationBar.backgroundColor = .babbelColor
        navigationController.navigationBar.layoutIfNeeded()
    }
}

