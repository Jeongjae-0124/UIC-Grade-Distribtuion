//
//  MyTableViewCell.swift
//  UICGrade
//
//  Created by Jeongjae on 11/9/22.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var courseInstr: UILabel!
    @IBOutlet weak var courseTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCellWithValuesOf(_ grade: Grade){
        courseTitle.text = grade.courTitle
        courseInstr.text = grade.instructor
        courseInstr.adjustsFontSizeToFitWidth=true
        courseTitle.adjustsFontSizeToFitWidth=true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
