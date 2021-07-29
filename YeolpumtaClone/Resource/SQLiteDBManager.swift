//
//  SQLiteDBManager.swift
//  YeolpumtaClone
//
//  Created by minii on 2021/07/25.
//

import UIKit
import SQLite3

// https://42kchoi.tistory.com/300
// https://upper-right.tistory.com/46
// http://monibu1548.github.io/2018/07/03/sqlite3/
// https://hururuek-chapchap.tistory.com/39
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
    // AUTOINCREMENT를 사용하기 위해서는 INT 가 아니라 INTEGER을 사용해야 한다.
    // 일반적인 mysql 문법을 사용할 수 있습니다.
    // 그런데 테이블 중복 생성 방지를 위해서 if not exists를 적어주는게 좋고
    // 정수는 가급적이면 integer로 문자열은 text로 해주는게 좋을 것 같습니다.
    func createTable() {
        let createTableQuery = """
            CREATE TABLE IF NOT EXISTS studytimes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            objdata TEXT not null
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
    func insertSQLiteTable(data: ObjData) {
        var insertStmt: OpaquePointer? = nil
        //autocrement일 경우에는 입력 부분에서는 컬럼을 추가 안해줘도 자동으로 추가가 되지만
        //쿼리 문에서는 이렇게 추가 해줘야합니다.
        let query = "INSERT INTO studytimes (id, objdata) VALUES (?, ?);"
        
        if sqlite3_prepare_v2(self.db, query, -1, &insertStmt, nil) == SQLITE_OK {
            
            do {
                //이렇게 데이터를 인코등 해주고 그 데이터를 String으로 변형 해준다.
                //왜냐하면 bind 해줄 때 data 타입이 없기 때문이다.
                let data = try JSONEncoder().encode(data)
                let dataToString = String(data: data, encoding: .utf8)
                //insert는 read와 다르게 컬럼의 순서의 시작을 1 부터 한다.
                //따라서 id가 없기 때문에 2로 시작한다.
                sqlite3_bind_text(insertStmt, 2, NSString(string: dataToString!).utf8String, -1, nil)
                
            } catch {
                print("Color JSONEncoder and bind_text ERROR")
            }
            
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
    func readSQLiteTable() -> [ObjData]? {
        let query = "SELECT * FROM studytimes;"
        var queryStmt: OpaquePointer? = nil
        var fetchedData: [ObjData] = []
        
        if sqlite3_prepare_v2(self.db, query, -1, &queryStmt, nil) == SQLITE_OK {
            while sqlite3_step(queryStmt) == SQLITE_ROW {
                
                // 만약에 컬럼이 objdata 하나 뿐이 였다면 반환되는 결과물도 objdata 하나 뿐이기 때문에
                let id = sqlite3_column_int(queryStmt, 0)
                // 이 부분이 1이 아니라 0이 되어야 한다.
                let data = String(cString: sqlite3_column_text(queryStmt, 1))
                
                do {
                    //sql에 data 타입이 아니라 String 타입으로 저장이 되어 있기 때문에, 반드시 String 타입을 data 타입으로 변경해서 디코드 해줘야한다.
                    let objdata = try JSONDecoder().decode(ObjData.self, from: data.data(using: .utf8)!)
                    fetchedData.append(objdata)
                    print("readSQLite Result : \(id) \(objdata)")
                } catch {
                    print("JSONDecoder Error : \(error.localizedDescription)")
                }
                
                
                
                
                
            }
        } else {
            print("read failed...")
        }
        
        sqlite3_finalize(queryStmt)
        
        return fetchedData
    }
    
    // 데이터
    func updateStudyTime(data: ObjData) {
        
    }
    
//    func readStudyTime() -> TimerData {
//
//    }
    
    func deleteStudyTime(id: Int) {
        
    }
    
}

struct ObjData: Codable {
    let name: String
    let color: Data
//
//    var colorData: Data? {
//        let colorData: Data? = UIColor.encode(self.color)()
//        return colorData
//    }
}

