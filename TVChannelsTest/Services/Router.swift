// Router.swift
// Copyright © Dmi3. All rights reserved.

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assembly: AssemblyProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetails()
}

final class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assembly: AssemblyProtocol?

    init(navigationController: UINavigationController, assembly: AssemblyProtocol) {
        self.navigationController = navigationController
        self.assembly = assembly
    }

    func initialViewController() {
        if let navigationController = navigationController {
            guard let channelsViewController = assembly?.createChannelsModule(router: self) else { return }
            navigationController.viewControllers = [channelsViewController]
        }
    }

    func showDetails() {
        if let navigationController = navigationController {
            guard let detailViewController = assembly?.createDetailsModule(router: self) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
}
