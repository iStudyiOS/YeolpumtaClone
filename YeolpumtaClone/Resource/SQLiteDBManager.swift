//
//  SQLiteDBManager.swift
//  YeolpumtaClone
//
//  Created by minii on 2021/07/25.
//

import Foundation
import SQLite3

// https://42kchoi.tistory.com/300
// https://upper-right.tistory.com/46

class SQLiteDBManager {
    
    static let shared = SQLiteDBManager()
    
    var db: OpaquePointer?
    
    init() {
        self.db = createDB()
        createTable()
    }
}

extension SQLiteDBManager {
    // DB 생성
    func createDB() -> OpaquePointer? {
        let path: String = "StudyTimesDB.sqlite"
        
        var db: OpaquePointer? = nil
        
        // document 디렉토리에 SQLite 생성하기
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(path)
        
        // dbㅇ
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("Error while creating db")
            return nil
        } else {
            print("Database has been created with path : \(path)")
            return db
        }
    }
    
    // DB안에 Table 생성
    func createTable() {
        let createTableQuery = """
            CREATE TABLE IF NOT EXISTS studytimes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name CHAR(255)
            );
            """
        
        var createTableStmt: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, createTableQuery, -1, &createTableStmt, nil) == SQLITE_OK {
            if sqlite3_step(createTableStmt) == SQLITE_DONE {
                print("table creation has been successfullty done")
            }
            else {
                print("table creation failure")
            }
        } else {
            print("Preparation for creating table has been failed")
        }
        
        sqlite3_finalize(createTableStmt)
    }
    
    // 데이터 table에 넣기
    func insertSQLiteTable(name: String) {
        var insertStmt: OpaquePointer? = nil
        let insertStmtString = "INSERT INTO studytimes (name) VALUES (?);"
        
        if sqlite3_prepare_v2(self.db, insertStmtString, -1, &insertStmt, nil) == SQLITE_OK {
            let insertName = NSString(string: name)
            
            sqlite3_bind_text(insertStmt, 1, insertName.utf8String, -1, nil)
            
            if sqlite3_step(insertStmt) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        
        sqlite3_finalize(insertStmt)
    }
    
    // 데이터 table에서 읽어오기
    func readSQLiteTable() {
        let queryStmtString = "SELECT * FROM studytimes;"
        var queryStmt: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, queryStmtString, -1, &queryStmt, nil) == SQLITE_OK {
            while sqlite3_step(queryStmt) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStmt, 0)
                
                guard let queryResultCol1 = sqlite3_column_text(queryStmt, 1) else {
                    print("no queryResultCol1...")
                    return
                }
                let name = String(cString: queryResultCol1)
                
                print("\(id)|\(name)")
            }
        } else {
            print("read failed...")
        }
        
        sqlite3_finalize(queryStmt)
    }
    
    // 데이터
    func updateStudyTime(data: TimerData) {
        
    }
    
//    func readStudyTime() -> TimerData {
//
//    }
    
    func deleteStudyTime(id: Int) {
        
    }
    
}

struct TimerData {
    var id: Int
    var name: String
    var time: String
}
