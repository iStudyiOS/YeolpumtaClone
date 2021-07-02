//
//  HomeViewController.swift
//  YeolpumtaClone
//
//  Created by 김진태 on 2021/06/13.
//

import SnapKit
import UIKit
import SQLite3

class HomeViewController: UIViewController {
    // MARK: - Property
    
    static let homeViewController = HomeViewController()

    var objectList = [ObjectForAdd]() {
        didSet { tableView.reloadData() }
    }
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: Constants.ImageName.plus), for: .normal)
        button.backgroundColor = .tintColor
        button.tintColor = .white
        button.addTarget(self, action: #selector(addObject), for: .touchUpInside)
        return button
    }()
    
    private let totalTimerView: UIView = {
        let view = UIView()
        view.backgroundColor = .tintColor
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        
        // 금일 날짜 표시
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy . M . d"
        
        label.text = dateFormatter.string(from: now)
        
        return label
    }()
    
    private let totalTimerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = .white
        label.text = "00:00:00"
        
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // for SQLite
            
    let tableOne = "TableOne"
    let tableTwo = "TableTwo"
    
    var db: OpaquePointer?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        makeQuery()
        readValues()
    }

    // MARK: - Helper

    fileprivate func setupUI() {
        setupTotalTimerView()
        setupTableView()
        setupAddButton()
    }

    fileprivate func setupAddButton() {
        view.addSubview(addButton)
        addButton.snp.makeConstraints {
            $0.width.height.equalTo(48)
            $0.right.equalToSuperview().offset(-32)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-24)
        }
        addButton.layer.cornerRadius = 48 / 2
    }
    
    fileprivate func setupTotalTimerView() {
        view.addSubview(totalTimerView)
        totalTimerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(160)
        }
        
        let stack = UIStackView(arrangedSubviews: [dateLabel, totalTimerLabel])
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        
        totalTimerView.addSubview(stack)
        stack.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    fileprivate func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(totalTimerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.register(HomeSectionCell.self, forCellReuseIdentifier: HomeSectionCell.cellIdentifier)
        tableView.register(HomeTimerCell.self, forCellReuseIdentifier: HomeTimerCell.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
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
    
    func delete(itemId: Int32) {
        var deleteStatement: OpaquePointer?
        let deleteStatementString = "DELETE FROM \(tableOne) WHERE Id = ?;"

        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) ==
          SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, itemId)
            
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("\nSuccessfully deleted row.")
            } else {
                print("\nCould not delete row.")
            }
        } else {
            print("\nDELETE statement could not be prepared")
        }
//        change()
    }
    
    // Updating...
    func change() {
        createTwoTable()
        insert()
        drop()
        changeName()
    }
    
    func createTwoTable() {
        var changeStatement: OpaquePointer?
        let createStatementString = """
        CREATE TABLE IF NOT EXISTS \(tableTwo) (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT)
        """

        if sqlite3_prepare_v2(db, createStatementString, -1, &changeStatement, nil) ==
          SQLITE_OK {

            if sqlite3_step(changeStatement) == SQLITE_DONE {
                print("\nSuccessfully create new row.")
            } else {
                print("\nCould not create new row.")
            }
        } else {
            print("\nCREATE statement could not be prepared")
        }
        
      sqlite3_finalize(changeStatement)
    }
    
    func insert() {
        var changeStatement: OpaquePointer?
        let insertStatementString = "INSERT INTO \(tableTwo) (id, name) select id, name from \(tableOne) o(id, name);"

        if sqlite3_prepare_v2(db, insertStatementString, -1, &changeStatement, nil) ==
          SQLITE_OK {

            if sqlite3_step(changeStatement) == SQLITE_DONE {
                print("\nSuccessfully insert new row.")
            } else {
                print("\nCould not insert new row.")
            }
        } else {
            print("\nCREATE22 statement could not be prepared")
        }
        sqlite3_finalize(changeStatement)
    }
    
    func drop() {
        var changeStatement: OpaquePointer?
        let dropStatementString = "DROP TABLE \(tableOne)"
        
        if sqlite3_prepare_v2(db, dropStatementString, -1, &changeStatement, nil) ==
          SQLITE_OK {

            if sqlite3_step(changeStatement) == SQLITE_DONE {
                print("\nSuccessfully drop old row.")
            } else {
                print("\nCould not drop old row.")
            }
        } else {
            print("\nCREATE statement could not be prepared")
        }
        sqlite3_finalize(changeStatement)
    }
    
    func changeName() {
        var changeStatement: OpaquePointer?
        let alterStaatementString = "ALTER TABLE \(tableTwo) rename to \(tableOne);"
        
        if sqlite3_prepare_v2(db, alterStaatementString, -1, &changeStatement, nil) ==
          SQLITE_OK {

            if sqlite3_step(changeStatement) == SQLITE_DONE {
                print("\nSuccessfully alter row.")
            } else {
                print("\nCould not alter row.")
            }
        } else {
            print("\nCREATE statement could not be prepared")
        }
    sqlite3_finalize(changeStatement)
    }
    
    // MARK: - Actions
    
    @objc func addObject() {
        let controller = AddObjectController()
        navigationController?.pushViewController(controller, animated: true)
        controller.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        
        return 1 + objectList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeSectionCell.cellIdentifier, for: indexPath) as? HomeSectionCell else {
                fatalError("tableView에서 HomeSectionCell을 dequeue하던 과정에서 에러가 발생하였습니다")
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTimerCell.cellIdentifier, for: indexPath) as? HomeTimerCell else {
                fatalError("tableView에서 HomeTimerCell을 dequeue하던 과정에서 에러가 발생하였습니다")
            }
            cell.goalLabel.text = "\(objectList[indexPath.row - 1].name)"
            print("\(objectList[indexPath.row - 1])")

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            tableView.beginUpdates()
            
            objectList.remove(at: indexPath.row - 1)
            tableView.deleteRows(at: [indexPath], with: .fade)
            print("done")
            // * 현재 delete시 SQLite table의 정확한 데이터를 삭제하지 못합니다. 디버깅 필요
            delete(itemId: Int32(indexPath.row))
            readValues()

        }
    }
}
