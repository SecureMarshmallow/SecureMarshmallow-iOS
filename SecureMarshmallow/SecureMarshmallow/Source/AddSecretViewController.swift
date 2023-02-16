//
//  AddSecretViewController.swift
//  SecureMarshmallow
//
//  Created by 박준하 on 2023/02/16.
//  Copyright © 2023 SecureMarshmallow. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

class AddSecretViewController: BaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.largestUndimmedDetentIdentifier = .large
            let id = UISheetPresentationController.Detent.Identifier("SignCustom")
            let SignCustomDetent = UISheetPresentationController.Detent.custom(identifier: id) { context in
                return 800
            }
            sheetPresentationController.detents = [SignCustomDetent]
        }
    }
}


