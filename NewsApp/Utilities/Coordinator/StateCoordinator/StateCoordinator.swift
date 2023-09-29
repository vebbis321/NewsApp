//
//  StateCoordinator.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/28/23.
//

import UIKit

protocol StateCoordinator: Coordinator {
    var rootViewController: UINavigationController { get set }
    var parentCoordinator: ApplicationCoordinator? { get set }
}
