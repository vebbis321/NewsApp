//
//  ApplicationCoordinator.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/28/23.
//

import UIKit

final class ApplicationCoordinator: Coordinator {

    private let window: UIWindow

    private var childCoordinators: [StateCoordinator] = [StateCoordinator]()

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let childCoordinator = InAppCoordinator()
        window.rootViewController = childCoordinator.rootViewController
        childCoordinator.parentCoordinator = self
        childCoordinator.start()
        childCoordinators.removeAll() // if more state coordinators exists
        childCoordinators.append(childCoordinator)
    }

    deinit {
        print("✅ Deinit ApplicationCoordinator")
    }
}
