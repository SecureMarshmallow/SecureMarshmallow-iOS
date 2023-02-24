//
//  UserViewController.swift
//  SecureMarshmallow
//
//  Created by 박준하 on 2023/02/15.
//

import UIKit

class UserViewController: BaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
    
    
    override func viewDidLayoutSubviews() {
        tabBarController?.addSubviewToLastTabItem("TemporaryProfile")
    }
}
