// SceneDelegate.swift
// Copyright © Dmi3. All rights reserved.

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window?.windowScene = windowScene

        let navigationController = UINavigationController()
        let assembly = Assembly()
        let router = Router(navigationController: navigationController, assembly: assembly)
        router.initialViewController()

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
