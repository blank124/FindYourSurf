//
//  SceneDelegate.swift
//  FindYourSurf
//
//  Created by Michael Blank on 1/15/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = WelcomeViewController()
        self.window = window
        window.makeKeyAndVisible()
    }
}
