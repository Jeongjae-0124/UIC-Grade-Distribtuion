//
//  SearchViewController.swift
//  UICGrade
//
//  Created by Jeongjae on 11/3/22.
//

import UIKit
import DropDown
import Toast_Swift

public var term:String=""
public var year:String=""

class SearchViewController: UIViewController {
    var termDropdown:DropDown?
    var yearDropdown:DropDown?
    var mainList = [Grade]()
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var termText: UITextField!
    @IBOutlet weak var yearButton: UIButton!
    @IBOutlet weak var termButton: UIButton!
    @IBOutlet weak var courseNum: UITextField!
    @IBOutlet weak var courseAbb: UITextField!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardObserver()
        termDropdown=DropDown()
        yearDropdown=DropDown()
        termDropdown?.anchorView=termButton
        yearDropdown?.anchorView=yearButton
        
        termDropdown?.dataSource=["SP","SU","FA"]
        yearDropdown?.dataSource=["10","11","12","13","14","15","16","17","18","19","20","21"]
        termButton.addTarget(self, action: #selector(termDropDownButton), for:.touchUpInside)
        yearButton.addTarget(self, action: #selector(yearDropDownButton), for:.touchUpInside)
        termDropdown?.selectionAction={[unowned self](index: Int, item:String) in
            self.termText.text=item}
        yearDropdown?.selectionAction={[unowned self](index: Int, item:String) in
            self.yearText.text=item}
        messageLabel.font=UIFont.systemFont(ofSize: 100)
        messageLabel.adjustsFontForContentSizeCategory=true
        messageLabel.minimumScaleFactor=0.1
        termLabel.adjustsFontSizeToFitWidth=true
        courseLabel.adjustsFontSizeToFitWidth=true
        courseAbb.adjustsFontSizeToFitWidth=true
        courseNum.adjustsFontSizeToFitWidth=true
        yearText.adjustsFontSizeToFitWidth=true
        termText.adjustsFontSizeToFitWidth=true
        courseAbb.layer.cornerRadius=8
        courseNum.layer.cornerRadius=8
        termButton.layer.cornerRadius=8
        yearButton.layer.cornerRadius=8
    }
    
    @IBAction func sendData(_ sender: Any) {
        let dbmanager=DBHelper()
        term=(termText.text?.lowercased())!
        year=yearText.text!
        if (courseAbb.text?.isEmpty ?? true || courseNum.text?.isEmpty ?? true) {
            self.view.makeToast("ERROR:Enter the course")
        }
        else{
            mainList = dbmanager.getSomeGrade(courAbb:courseAbb.text!,courNum: Int(courseNum.text ?? "") ?? 0)
            if (mainList.count==0 ){
                self.view.makeToast("ERROR:Could not find the course")
            }
            else if (mainList.count == 1){
                var gradeselected = mainList[0]
                let vr = storyboard?.instantiateViewController(identifier: "GradeDetailViewController")as! GradeDetailViewController
                vr.gradeselected = gradeselected
                self.navigationController?.pushViewController(vr, animated:true)
            }
            else{
                let vc = storyboard?.instantiateViewController(identifier: "ListViewController")as! ListViewController
                vc.titleText=termText.text!+yearText.text!+"  "+courseAbb.text!.uppercased()+courseNum.text!
                vc.courseAbb = courseAbb.text!.uppercased()
                vc.courseNum = courseNum.text!
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @objc func termDropDownButton(){
        termDropdown?.show()
    }
    @objc func yearDropDownButton(){
        yearDropdown?.show()
    }
    
 
   
   
}

extension UIViewController {
    func setKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object:nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
          if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                  let keyboardRectangle = keyboardFrame.cgRectValue
                  let keyboardHeight = keyboardRectangle.height
              UIView.animate(withDuration: 1) {
                  if self.view.window?.frame.origin.y == 0{
                      self.view.window?.frame.origin.y -= keyboardHeight/4
                  }
        
    
              }
          }
      }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.window?.frame.origin.y != 0 {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                    let keyboardRectangle = keyboardFrame.cgRectValue
                    let keyboardHeight = keyboardRectangle.height
                UIView.animate(withDuration: 1) {
                    self.view.window?.frame.origin.y += keyboardHeight/4
                }
            }
        }
    }
}

