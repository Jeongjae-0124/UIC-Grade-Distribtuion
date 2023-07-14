//
//  GradeDetailViewController.swift
//  UICGrade
//
//  Created by Jeongjae on 11/8/22.
//

import UIKit
import Charts
import SafariServices
class GradeDetailViewController: UIViewController {
    var gradeselected:Grade?
    var link:String?
    @IBOutlet weak var withdraw: UILabel!
    @IBOutlet weak var totalReg: UILabel!
    @IBOutlet weak var satUnsat: UILabel!
    @IBOutlet weak var barGraphView: BarChartView!
    @IBOutlet weak var courseAbb: UILabel!
    @IBOutlet weak var courseTerm: UILabel!
    @IBOutlet weak var courseInstr: UILabel!
    @IBOutlet weak var courseTitle: UILabel!
  
    
    @IBOutlet weak var rateMyProf: UIButton!
    
    @IBAction func rateMyProf(_ sender: Any) {
        var target = gradeselected?.instructor?.firstIndex(of: ",")
        var nextTarget = (gradeselected?.instructor?.index(target!, offsetBy: 2))!
        if target != nil{
            var lastName = gradeselected?.instructor?.substring(to: target!)
            var firstName = gradeselected?.instructor?.substring(from: nextTarget)
            if (lastName?.firstIndex(of: " ") != nil){
                var target_lastName = lastName?.firstIndex(of: " ")
                lastName = lastName?.substring(to:target_lastName!)
            }
            if (firstName?.firstIndex(of: " ") != nil){
                var target_firstName = firstName?.firstIndex(of: " ")
                firstName = firstName?.substring(to:target_firstName!)
            }
            print(lastName)
            print(firstName)
            link = "https://www.ratemyprofessors.com/search/teachers?query="
            + firstName!+"%20" + lastName! + "&sid=U2Nob29sLTExMTE=";
            print(link)
        }
        let blogUrl = NSURL(string: link!)
          let blogSafariView: SFSafariViewController = SFSafariViewController(url: blogUrl as! URL)
          self.present(blogSafariView, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.courseTitle.numberOfLines=0
        courseTitle.adjustsFontSizeToFitWidth=true
        courseTerm.text = "Term: "+term + year
        courseInstr.text = gradeselected!.instructor
        courseTitle.text = gradeselected!.courTitle
        courseAbb.text = (gradeselected!.courAbb?.uppercased())! + String(gradeselected!.courNum)
        withdraw.text = "Withdraw: " + String(gradeselected!.withdraw)
        totalReg.text = "Total Registered: " + String(gradeselected!.regs)
        satUnsat.text = "Satisfactory/Unsatisfactory: " + String(gradeselected!.satis) + "/" + String(gradeselected!.unsatis)
        createChart()
        if(courseInstr.text == "Grad Asst"){
            rateMyProf.isHidden = true
        }
        
    }
    
    private func createChart(){
        var dataPoints: [String]=["A","B","C","D","F"]
        var dataEntries:[BarChartDataEntry]=[]
        let Apercent = (Float(gradeselected?.aNum ?? 0) / Float(gradeselected?.regs ?? 0))*100
        print(gradeselected?.aNum)
        let Bpercent = (Float(gradeselected?.bNum ?? 0) / Float(gradeselected?.regs ?? 0))*100
        let Cpercent = (Float(gradeselected?.cNum ?? 0) / Float(gradeselected?.regs ?? 0))*100
        let Dpercent = (Float(gradeselected?.dNum ?? 0) / Float(gradeselected?.regs ?? 0))*100
        let Fpercent = (Float(gradeselected?.fNum ?? 0) / Float(gradeselected?.regs ?? 0))*100
        var dataArray:[Float] = [Apercent,Bpercent,Cpercent,Dpercent,Fpercent]
        for i in 0...4{
            let dataEntry = BarChartDataEntry(x: Double(i),y:Double(dataArray[i]))
            dataEntries.append(dataEntry)
        }
       
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "graph data")
        let chartData = BarChartData(dataSet: chartDataSet)
        
       
        barGraphView.xAxis.drawAxisLineEnabled=false
        barGraphView.legend.enabled = false
        barGraphView.chartDescription.enabled = false
        barGraphView.xAxis.drawGridLinesEnabled=false
        barGraphView.xAxis.labelPosition = .bottom
        barGraphView.xAxis.labelFont = UIFont.systemFont(ofSize: 20)
        barGraphView.xAxis.setLabelCount(dataPoints.count, force: false)
        barGraphView.xAxis.valueFormatter=IndexAxisValueFormatter(values: dataPoints)
        barGraphView.leftAxis.drawGridLinesEnabled=false
        barGraphView.leftAxis.drawAxisLineEnabled=false
        barGraphView.leftAxis.drawLabelsEnabled=false
        
        barGraphView.rightAxis.drawAxisLineEnabled=false
        barGraphView.rightAxis.drawLabelsEnabled = false
        barGraphView.rightAxis.drawGridLinesEnabled=false
        
        chartDataSet.valueFont=UIFont.systemFont(ofSize: 20)
        barGraphView.xAxis.yOffset=0
        
        barGraphView.data = chartData
        let valFormatter = NumberFormatter()
        valFormatter.numberStyle = .percent
        valFormatter.maximumFractionDigits=1
        valFormatter.percentSymbol="%"
        valFormatter.multiplier=1.0
        let valFormat = DefaultValueFormatter(formatter: valFormatter)
        chartDataSet.valueFormatter=valFormat
        
        
        
    }
    
    


}
