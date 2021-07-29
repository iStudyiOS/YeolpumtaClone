//
//  AddObjectController.swift
//  YeolpumtaClone
//
//  Created by 김태균 on 2021/06/25.
//

import UIKit
import SnapKit

class AddObjectController: UIViewController {
    // MARK: - Properties
        
    let sql = SQLiteDBManager.shared
    
    private let objectLabel: UILabel = {
        let label = UILabel()
        label.text = "측정할 과목 이름"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .tintColor
        return label
    }()
    
    private let textField: UITextField = {
        let field = UITextField(frame: CGRect(x: 0, y: 0, width: 150, height: 32))
        field.attributedPlaceholder = NSAttributedString(string: "e.g. 수학,영어,과학,역사..", attributes: [.foregroundColor : UIColor.systemGray])
        field.font = UIFont.systemFont(ofSize: 16)
        
        return field
    }()
    
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "색상선택"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .tintColor
        return label
    }()
    
    private var colorButton: UIButton = {
        let bt = UIButton()
        bt.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
        bt.layer.cornerRadius = 40 / 2
        bt.backgroundColor = .red
        bt.addTarget(self, action: #selector(didTapColorButton), for: .touchUpInside)

        return bt
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "과목 추가하기"
       
        configureNavBar()
        configureUI()
    }
    
    // MARK: - Helpers
    
    private func configureNavBar() {
        // 기존 버튼 삭제 ( defualt값을 변경하기 위해 여러 번 시도하였지만, 변경을 못해 제거하고 leftBarButtonItem을 추가합니다 )
        navigationItem.hidesBackButton = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(handleDismissal))
        navigationItem.leftBarButtonItem?.tintColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .done, target: self, action: #selector(makeTable))
        navigationItem.rightBarButtonItem?.tintColor = .white

    }
    
    // 추가하기 버튼 누를시..
    @objc func makeTable() {
        
        guard let name = self.textField.text,
              !name.isEmpty else {
            alertFillTextField()
            return
        }
        
        guard let color = self.colorButton.backgroundColor else {
            print("no backgroundcolor??")
            return
        }
        
        guard let colorToData = UIColor.encode(color)() else {
            print("colorToData error...")
            return
        }
        
        let data = ObjData(name: name, color: colorToData)
        sql.insertSQLiteTable(data: data)
        navigationController?.popViewController(animated: true)
    }
    
    func alertFillTextField() {
        let alert = UIAlertController(title: "경고", message: "빈칸을 모두 채워주세요!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "돌아가기", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func configureUI() {
        
        view.addSubview(objectLabel)
        objectLabel.snp.makeConstraints {
            $0.top.equalTo(view).offset(28)
            $0.leading.equalTo(view).offset(16)
        }
        
        view.addSubview(textField)
        textField.snp.makeConstraints {
            $0.top.equalTo(objectLabel).offset(28)
            $0.leading.equalTo(view).offset(20)
            $0.trailing.equalTo(view).offset(-32)
        }
        
        view.addSubview(colorLabel)
        colorLabel.snp.makeConstraints {
            $0.top.equalTo(textField).offset(40)
            $0.leading.equalTo(view).offset(16)
        }
        
        view.addSubview(colorButton)
        colorButton.snp.makeConstraints {
            $0.top.equalTo(colorLabel).offset(28)
            $0.leading.equalTo(view).offset(20)
        }
    }
    
    // MARK: - Actions
    
    @objc private func handleDismissal() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapColorButton() {
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        present(colorPickerVC, animated: true)
    }
}
// MARK: - UIColorPickerViewControllerDelegate

extension AddObjectController: UIColorPickerViewControllerDelegate {
    // color 선택시 버튼 색상 변경
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        colorButton.backgroundColor = color
    }
}

