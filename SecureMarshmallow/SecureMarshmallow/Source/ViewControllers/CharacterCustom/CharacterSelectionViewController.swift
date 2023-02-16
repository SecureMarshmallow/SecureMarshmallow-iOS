//
//  CharacterSelectionViewController.swift
//  SecureMarshmallow
//
//  Created by 박준하 on 2023/02/06.
//

import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift

class CharacterSelectionViewController: UIViewController {
    
    static var userEmoji: String = ""
    static var userBackground = UIColor()
    var charOrBack = true
    
    var array = ["0","1","2","3","4","5","6","7","8"]
    let sectionInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
    
    private lazy var backgroundView = UIView().then {
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 70 * (view.frame.width / 430)
    }
    
    private lazy var emojiCharacter = UILabel().then {
        $0.font = .systemFont(ofSize: 100.0, weight: .black)
        $0.text = ""
    }
    
    private lazy var askingLable = UILabel().then {
        $0.font = .systemFont(ofSize: 25.0, weight: .black)
        $0.text = "아바타를 선택해주세요."
    }
    
    private lazy var characterButton = RadioButton().then {
        $0.setTitle("아바타 고르기", for: .normal)
        $0.setTitleColor(UIColor(ciColor: .white), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .bold)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 30  * (view.frame.width / 430)
        $0.layer.borderWidth = 0.0
        
        $0.rx.tap
            .bind {
                self.charOrBack = true
                self.collectionView.reloadData()
                print("true")
            }
    }
    
    private lazy var backgroundButton = RadioButton().then {
        $0.setTitle("바탕 고르기", for: .normal)
        $0.setTitleColor(UIColor(ciColor: .white), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .bold)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 30  * (view.frame.width / 430)
        $0.layer.borderWidth = 0.0
        
        $0.rx.tap
            .bind {
                self.charOrBack = false
                self.collectionView.reloadData()
                print("false")
            }
    }
    
    var collectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        
        cv.register(CharacterCollectionCell.self, forCellWithReuseIdentifier: CharacterCollectionCell.identifier)
        return cv
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        characterButton.isSelected = true
        backgroundButton.isSelected = false
        
        CharacterSelectionViewController.userBackground = .gray
        emojiCharacter.text = "🐰"

    }
    
    override func viewDidLoad() {

        characterButton.alternateButton = [backgroundButton]
        backgroundButton.alternateButton = [characterButton]
        
        setupNavigationController()
        layout()
        
        collectionView.delegate = self
        collectionView.dataSource = nil
        
        let data = Observable<[String]>.of(self.array)
        
        print("구독은 됨")
        
            data.asObservable()
                .bind(to: self.collectionView.rx
                    .items(cellIdentifier: CharacterCollectionCell.identifier, cellType: CharacterCollectionCell.self)
                ) { index, recommend, cell in
                    print("CharacterCollectionCell 데이터불러오기 성공")
                    cell.layout()
                    cell.imageView.backgroundColor = .gray
                    cell.imageView.layer.cornerRadius = 55 * (self.view.frame.width / 430)
                    cell.layer.cornerRadius = 200  * (self.view.frame.width / 430)
                    
                    if self.charOrBack == true {
                        if index == 0 {
                            cell.titleLabel.text = "🐻‍❄️"
                        } else if index == 1 {
                            cell.titleLabel.text = "🦁"
                        } else if index == 2 {
                            cell.titleLabel.text = "🐵"
                        } else if index == 3 {
                            cell.titleLabel.text = "🐭"
                        } else if index == 4 {
                            cell.titleLabel.text = "🐰"
                        } else if index == 5 {
                            cell.titleLabel.text = "🐸"
                        } else if index == 6 {
                            cell.titleLabel.text = "🐱"
                        } else if index == 7 {
                            cell.titleLabel.text = "🐶"
                        } else{
                            cell.titleLabel.text = "🐼"
                        }
                    }
                    if self.charOrBack == false {
                        if index == 0 {
                            cell.titleLabel.text = CharacterSelectionViewController.userEmoji
                            cell.imageView.backgroundColor = .gray
                        } else if index == 1 {
                            cell.titleLabel.text = CharacterSelectionViewController.userEmoji
                            cell.imageView.backgroundColor = .black
                        } else if index == 2 {
                            cell.titleLabel.text = CharacterSelectionViewController.userEmoji
                            cell.imageView.backgroundColor = .orange
                        } else if index == 3 {
                            cell.titleLabel.text = CharacterSelectionViewController.userEmoji
                            cell.imageView.backgroundColor = .red
                        } else if index == 4 {
                            cell.titleLabel.text = CharacterSelectionViewController.userEmoji
                            cell.imageView.backgroundColor = .blue
                        } else if index == 5 {
                            cell.titleLabel.text = CharacterSelectionViewController.userEmoji
                            cell.imageView.backgroundColor = .yellow
                        } else if index == 6 {
                            cell.titleLabel.text = CharacterSelectionViewController.userEmoji
                            cell.imageView.backgroundColor = .green
                        } else if index == 7 {
                            cell.titleLabel.text = CharacterSelectionViewController.userEmoji
                            cell.imageView.backgroundColor = .systemPink
                        } else{
                            cell.titleLabel.text = CharacterSelectionViewController.userEmoji
                            cell.imageView.backgroundColor = .purple
                        }
                    }
                }
    }
    
    func layout() {
        [
            backgroundView,
            emojiCharacter,
            askingLable,
            characterButton,
            backgroundButton,
            collectionView
        ].forEach { view.addSubview($0) }
        
        let width = view.frame.width / 430
        let height = view.frame.height / 932
        
        backgroundView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(140.0 * height)
            $0.width.equalTo(140.0 * width)
        }
        
        emojiCharacter.snp.makeConstraints {
            $0.centerY.equalTo(backgroundView.snp.centerY)
            $0.centerX.equalTo(backgroundView.snp.centerX)
        }
        
        askingLable.snp.makeConstraints {
            $0.top.equalTo(backgroundView.snp.bottom).offset(20.0 * height)
            $0.centerX.equalTo(backgroundView.snp.centerX)
        }
        
        characterButton.snp.makeConstraints {
            $0.top.equalTo(askingLable.snp.bottom).offset(25.0 * height)
            $0.leading.equalToSuperview().inset(30.0 * width)
            $0.height.equalTo(60.0 * height)
            $0.width.equalTo(180.0 * width)
        }
        
        backgroundButton.snp.makeConstraints {
            $0.top.equalTo(characterButton.snp.top)
            $0.trailing.equalToSuperview().inset(30.0 * width)
            $0.height.equalTo(characterButton.snp.height)
            $0.width.equalTo(characterButton.snp.width)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(backgroundButton.snp.bottom).offset(52.0 * height)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(40 * height)
        }
    }
    
    
    func setupNavigationController() {

        let bar: UINavigationBar! = self.navigationController?.navigationBar

        bar.backgroundColor = .clear
        bar.setBackgroundImage(UIImage(), for: .default)
        bar.shadowImage = UIImage()
        bar.isTranslucent = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completeEvent))
    }
    
    @objc
    func completeEvent() {
        print("완료했습니다")
        self.navigationController?.pushViewController(CompleteViewController(), animated: true)
    }
}

extension CharacterSelectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing : CGFloat = 10
        
        let width : CGFloat = (collectionView.bounds.width - 65 - itemSpacing * 2) / 3
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)가 눌렸어")
        if self.charOrBack == true {
            if indexPath.row == 0 {
                CharacterSelectionViewController.userEmoji = "🐻‍❄️"
            } else if indexPath.row == 1 {
                CharacterSelectionViewController.userEmoji = "🦁"
            } else if indexPath.row == 2 {
                CharacterSelectionViewController.userEmoji = "🐵"
            } else if indexPath.row == 3 {
                CharacterSelectionViewController.userEmoji = "🐭"
            } else if indexPath.row == 4 {
                CharacterSelectionViewController.userEmoji = "🐰"
            } else if indexPath.row == 5 {
                CharacterSelectionViewController.userEmoji = "🐸"
            } else if indexPath.row == 6 {
                CharacterSelectionViewController.userEmoji = "🐱"
            } else if indexPath.row == 7 {
                CharacterSelectionViewController.userEmoji = "🐶"
            } else {
                CharacterSelectionViewController.userEmoji = "🐼"
            }
            emojiCharacter.text = CharacterSelectionViewController.userEmoji
        } else {
            if indexPath.row == 0 {
                CharacterSelectionViewController.userBackground = .gray
            } else if indexPath.row == 1 {
                CharacterSelectionViewController.userBackground = .black
            } else if indexPath.row == 2 {
                CharacterSelectionViewController.userBackground = .orange
            } else if indexPath.row == 3 {
                CharacterSelectionViewController.userBackground = .red
            } else if indexPath.row == 4 {
                CharacterSelectionViewController.userBackground = .blue
            } else if indexPath.row == 5 {
                CharacterSelectionViewController.userBackground = .yellow
            } else if indexPath.row == 6 {
                CharacterSelectionViewController.userBackground = .green
            } else if indexPath.row == 7 {
                CharacterSelectionViewController.userBackground = .systemPink
            } else {
                CharacterSelectionViewController.userBackground = .purple
            }
            backgroundView.backgroundColor = CharacterSelectionViewController.userBackground
        }
    }
}
