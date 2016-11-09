//
//  WeatherViewController.swift
//  BoxCricket
//
//  Created by Fnu, Rohit on 11/9/16.
//  Copyright © 2016 Fnu, Rohit. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class WeatherViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    var arrRes = [[String:AnyObject]]() //Array of dictionary

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*Alamofire.request("http://cricapi.com/api/cricket").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                print(swiftyJsonVar)
            }
        }*/
        Alamofire.request("http://cricapi.com/api/cricket").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["data"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count > 0 {
                    self.tableView.reloadData()
                }
            }
        }
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        var dict = arrRes[indexPath.row]
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.font = UIFont(name:"Avenir", size:17)
        cell.textLabel?.text = dict["title"] as? String
        
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.detailTextLabel?.font = UIFont(name:"Avenir", size:22)
        cell.detailTextLabel?.text = dict["description"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
    

    
    
    @IBAction func closeButton_touchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }



}
