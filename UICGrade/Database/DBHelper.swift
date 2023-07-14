//
//  DBHelper.swift
//  UICGrade
//
//  Created by Jeongjae on 11/6/22.
//

import Foundation
import SQLite3

class DBHelper{
    static func getDatabasePointer(databaseName:String) -> OpaquePointer?{
        
        var databasePointer : OpaquePointer?
        let documentDatabasePath = FileManager.default.urls(for:.documentDirectory , in:
                .userDomainMask)[0].appendingPathComponent(databaseName).path
        
        if FileManager.default.fileExists(atPath: documentDatabasePath){
            print("Database Exists(already)")
        }
        
        else{
            guard let bundleDatabasePath = Bundle.main.resourceURL?.appendingPathComponent(databaseName).path else{
                print("Unwrapping Error: Bundle Database Path doesn't exist")
                return nil
            }
            do{
                try FileManager.default.copyItem(atPath: bundleDatabasePath, toPath: documentDatabasePath)
                print("Database created (copied)")
            } catch{
                print("Error:\(error.localizedDescription)")
                return nil
            }
        }
        if sqlite3_open(documentDatabasePath,&databasePointer)==SQLITE_OK{
            print("Successfully open database")
            print("Database path:\(documentDatabasePath)")
        }
        else{
            print("Could not open database")
        }
        return databasePointer
    }
    
    
    func getSomeGrade(courAbb:String, courNum:Int)-> [Grade]{
        var mainList = [Grade]()
        let tableName = term.lowercased()+year
        let query="SELECT * FROM \(tableName) WHERE CRSSUBJCD = ? AND CRSNBR = ? "
        var statement : OpaquePointer?
        if sqlite3_prepare_v2(databasePointer, query, -1, &statement, nil) == SQLITE_OK{
           
            sqlite3_bind_text(statement, 1, (courAbb.uppercased() as NSString).utf8String,-1 , nil)
            sqlite3_bind_int(statement, 2, Int32(courNum))
            while sqlite3_step(statement) == SQLITE_ROW{
                let courAbb = String(describing:String(cString:sqlite3_column_text(statement, 0)))
                let courNum = Int(sqlite3_column_int(statement, 1))
                let courTitle = String(describing:String(cString:sqlite3_column_text(statement, 2)))
                let deptCd = Int(sqlite3_column_int(statement, 3))
                let deptName = String(describing:String(cString:sqlite3_column_text(statement, 4)))
                let aNum = Int(sqlite3_column_int(statement, 5))
                let bNum = Int(sqlite3_column_int(statement, 6))
                let cNum = Int(sqlite3_column_int(statement, 7))
                let dNum = Int(sqlite3_column_int(statement, 8))
                let fNum = Int(sqlite3_column_int(statement, 9))
                let advance = Int(sqlite3_column_int(statement, 10))
                let credit = Int(sqlite3_column_int(statement, 11))
                let deferred = Int(sqlite3_column_int(statement, 12))
                let incomplete = Int(sqlite3_column_int(statement, 13))
                let nonGrade = Int(sqlite3_column_int(statement, 14))
                let notReported = Int(sqlite3_column_int(statement, 15))
                let outstanding = Int(sqlite3_column_int(statement, 16))
                let proficient = Int(sqlite3_column_int(statement, 17))
                let satis = Int(sqlite3_column_int(statement, 18))
                let unsatis = Int(sqlite3_column_int(statement, 19))
                let withdraw = Int(sqlite3_column_int(statement, 20))
                let instructor = String(describing:String(cString:sqlite3_column_text(statement, 21)))
                let regs = Int(sqlite3_column_int(statement, 22))
                let grade = Grade()
                grade.courAbb = courAbb
                grade.courNum = courNum
                grade.courTitle = courTitle
                grade.deptCd = deptCd
                grade.deptName = deptName
                grade.aNum = aNum
                grade.bNum = bNum
                grade.cNum = cNum
                grade.dNum = dNum
                grade.fNum = fNum
                grade.advance = advance
                grade.credit = credit
                grade.deferred = deferred
                grade.incomplete = incomplete
                grade.nonGrade = nonGrade
                grade.notReported = notReported
                grade.outstanding = outstanding
                grade.proficient = proficient
                grade.satis = satis
                grade.unsatis = unsatis
                grade.withdraw = withdraw
                grade.instructor = instructor
                grade.regs = regs
                print(grade.instructor)
                mainList.append(grade)
                print(mainList.count)
            }
        }
        return mainList
    }
}
