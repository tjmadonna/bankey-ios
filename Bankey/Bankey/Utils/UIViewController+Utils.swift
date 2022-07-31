//
//  UIViewController+Utils.swift
//  Bankey
//
//  Created by Tyler Madonna on 7/30/22.
//

import UIKit

extension UIViewController {

    func setStatusBar() {
        if #available(iOS 13, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithTransparentBackground() // to hide Navigation Bar Line also
            navBarAppearance.backgroundColor = appColor
            UINavigationBar.appearance().standardAppearance = navBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        } else {
            let statusBarSize = UIApplication.shared.statusBarFrame.size
            let frame = CGRect(origin: .zero, size: statusBarSize)
            let statusBarView = UIView(frame: frame)
            statusBarView.backgroundColor = appColor
            view.addSubview(statusBarView)
        }
    }

    func setTabBarImage(imageName: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }

}
