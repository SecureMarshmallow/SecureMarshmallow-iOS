//
//  BaseVC.swift
//  SecureMarshmallow
//
//  Created by 박준하 on 2023/02/15.
//

import UIKit

import RxSwift
import RxCocoa
import RxRelay
import RxFlow

import Then
import SnapKit

import Alamofire
import Kingfisher

class BaseVC: UIViewController {
    let bound = UIScreen.main.bounds
    var disposeBag = DisposeBag()
    
    override func viewDidLayoutSubviews() { self.layout() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.bind()
        self.configure()
        self.view.setNeedsUpdateConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.attribute()
        self.touchEvent()
    }
    
    func touchEvent() { }
    func configure() { }
    func bind() { }
    func layout() { }
    func attribute() { }
}


