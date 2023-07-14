//
//  Grade.swift
//  UICGrade
//
//  Created by Jeongjae on 11/7/22.
//

import Foundation

class Grade :Identifiable {
    var courAbb:String?
    var courNum:Int=0
    var courTitle:String?
    var deptCd:Int=0
    var deptName:String?
    var aNum:Int=0
    var bNum:Int=0
    var cNum:Int=0
    var dNum:Int=0
    var fNum:Int=0
    var advance:Int=0
    var credit:Int=0
    var deferred:Int=0
    var incomplete:Int=0
    var nonGrade:Int=0
    var notReported:Int=0
    var outstanding:Int=0
    var proficient:Int=0
    var satis:Int=0
    var unsatis:Int=0
    var withdraw:Int=0
    var instructor:String?
    var regs:Int=0
}
