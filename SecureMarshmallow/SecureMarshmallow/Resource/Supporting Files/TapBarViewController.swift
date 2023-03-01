//
//  TapBarViewController.swift
//  SecureMarshmallow
//
//  Created by 박준하 on 2023/02/15.
//

import UIKit
import Then
import SnapKit

@available(iOS 16.0, *)
class TapBarViewController: UITabBarController {
    private lazy var homeViewController: UINavigationController = {
        let viewController = HomeViewController()
        let tabBarItem = UITabBarItem(title: "도원준", image: UIImage(systemName: "house.fill"), tag: 0)
        viewController.tabBarItem = tabBarItem
        let navigationView = UINavigationController(rootViewController: viewController)
        return navigationView
    }()
    
    private lazy var passwordViewController: UIViewController = {
        let viewController = SecretViewController()
        let tabBarItem = UITabBarItem(title: "비밀", image: UIImage(systemName: "lock.fill"), tag: 1)
        viewController.tabBarItem = tabBarItem
        let navigationView = UINavigationController(rootViewController: viewController)
        return navigationView
    }()
    
    private lazy var pictureViewController: UIViewController = {
        let viewController = UIViewController()
        let tabBarItem = UITabBarItem(title: "사진", image: UIImage(systemName: "photo.fill"), tag: 2)
        viewController.tabBarItem = tabBarItem
        let navigationView = UINavigationController(rootViewController: viewController)
        return navigationView
    }()
    
    private lazy var userViewController: UIViewController = {
        let viewController = SettingViewController()
        let tabBarItem = UITabBarItem(title: "유저", image: UIImage(named: ""), tag: 3)
        viewController.tabBarItem = tabBarItem
        let navigationView = UINavigationController(rootViewController: viewController)
        return navigationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [homeViewController, passwordViewController, pictureViewController, userViewController]
        configureTabBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 90
        tabFrame.origin.y = self.view.frame.size.height - 90
        self.tabBar.frame = tabFrame
    }
}

extension UITabBarController {
    
    func configureTabBar() {
        self.tabBar.tintColor = .label
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.layer.masksToBounds = true
        self.tabBar.layer.backgroundColor = UIColor.systemBackground.cgColor
        //        self.tabBar.layer.borderWidth = 0.4
    }
}

extension UITabBarController {
    
    func addSubviewToLastTabItem(_ imageName: String) {
        if let lastTabBarButton = self.tabBar.subviews.last, let tabItemImageView = lastTabBarButton.subviews.first {
            if let accountTabBarItem = self.tabBar.items?.last {
                accountTabBarItem.selectedImage = nil
                accountTabBarItem.image = nil
            }
            let imgView = UIImageView()
            imgView.frame = tabItemImageView.frame
            imgView.layer.cornerRadius = tabItemImageView.frame.height/3
            imgView.layer.masksToBounds = true
            imgView.contentMode = .scaleAspectFill
            imgView.clipsToBounds = true
            imgView.image = UIImage(named: imageName)
            
            imgView.snp.makeConstraints {
                $0.height.width.equalTo(40.0)
            }
            
            self.tabBar.subviews.last?.addSubview(imgView)
        }
    }
}
