//
//  AddObjectController.swift
//  YeolpumtaClone
//
//  Created by 김태균 on 2021/06/25.
//

import UIKit
import SnapKit
import SQLite3

class AddObjectController: UIViewController {
    // MARK: - Properties

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
    
    // for SQLite
    var objectList = [ObjectForAdd]() {
        didSet { HomeViewController().tableView.reloadData() }
    }
    
    let tableOne = "TableOne"
    let tableTwo = "TableTwo"
    
    var db: OpaquePointer?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "과목 추가하기"
       
        configureNavBar()
        configureUI()
        makeQuery()
        
//        deleteAll()
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
    
    // MARK: - SQLite
    
    func makeQuery() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                   .appendingPathComponent("\(tableOne)Database.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
                    print("error opening database")
        }
        
        
        let createTableString = """
        CREATE TABLE IF NOT EXISTS \(tableOne) (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT)
        """

        if sqlite3_exec(db, createTableString, nil, nil, nil) != SQLITE_OK {
                    let errmsg = String(cString: sqlite3_errmsg(db)!)
                    print("error creating table: \(errmsg)")
        }
    }
    
    @objc func makeTable() {
        let name = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)

        if(name?.isEmpty)!{
            textField.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        var stmt: OpaquePointer?
        let queryString = "INSERT INTO \(tableOne) (name) VALUES (?)"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        if sqlite3_bind_text(stmt, 1, name, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting hero: \(errmsg)")
            return
        }
            
        textField.text = ""
        
        readValues()
    
        print("Hero saved successfully")

        handleDismissal()
    }
    
    func readValues(){
   
        objectList.removeAll()
   
        let queryString = "SELECT * FROM \(tableOne)"
   
        var stmt:OpaquePointer?
   
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
   
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            
              objectList.append(ObjectForAdd(id: Int(id), name: String(describing: name)))
        }
    }
    
    // 모든 테이블 삭제
    func deleteAll() {
        var deleteStatement: OpaquePointer?
        let deleteStatementString = "DROP TABLE \(tableOne)"

        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) ==
          SQLITE_OK {
            
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("\nSuccessfully deleted table.")
                
            } else {
                print("\nCould not delete table.")
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
            print("\nDELETE statement could not be prepared")
        }
      sqlite3_finalize(deleteStatement)
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

// color를 데이터로 저장할 때 사용 - https://stackoverflow.com/questions/17230720/best-way-to-save-and-retrieve-uicolors-to-core-data
//extension UIColor {
//
//     class func color(data:Data) -> UIColor? {
//          return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
//     }
//
//     func encode() -> Data? {
//          return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
//     }
//}
