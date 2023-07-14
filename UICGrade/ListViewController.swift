//
//  ListViewController.swift
//  UICGrade
//
//  Created by Jeongjae on 11/7/22.
//

import UIKit

class ListViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var list_message: UILabel!
    var titleText=""
    var courseAbb=""
    var courseNum=""
    var mainList = [Grade]()
    let dbmanager=DBHelper()
    let screenRect = UIScreen.main.bounds
    var searchVC:UIViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        title=titleText
        list_message.adjustsFontSizeToFitWidth=true
        mainList = dbmanager.getSomeGrade(courAbb:courseAbb, courNum: Int(courseNum)!)
        tableView.dataSource=self
        tableView.delegate=self
        tableView.rowHeight = 88
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for:indexPath)
        let object = cellForRowAt(indexPath: indexPath)
        if let gradeCell = cell as? MyTableViewCell{
            gradeCell.setCellWithValuesOf(object)
        }
        return cell
    }
    
    func cellForRowAt(indexPath:IndexPath)-> Grade{
        return mainList[indexPath.row]
    }
    func tableView (_ tableView: UITableView, didSelectRowAt indexPath:IndexPath){
        var gradeselected = mainList[indexPath.row]
        let vr = storyboard?.instantiateViewController(identifier: "GradeDetailViewController")as! GradeDetailViewController
        vr.gradeselected = gradeselected
        self.navigationController?.pushViewController(vr, animated:true)
    }

}
