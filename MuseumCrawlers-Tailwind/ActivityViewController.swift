//
//  ActivityViewController.swift
//  MuseumCrawlers-Tailwind
//
//  Created by Brad Derstine on 5/6/18.
//  Copyright © 2018 Brad Derstine. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ActivityViewController: UIViewController {

    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var activityDescription: UILabel!
    
    let defaults = UserDefaults.standard
    
    let ACTIVITY_URL = "http://museumcrawlers.com/api/gallery/111/activity"
    let params : [ String: String ] = ["persona_id" : "2"]
    let rec = ActivityDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let team = defaults.object(forKey: "teamName") as! String
        teamName.text = team
        
        getActivityData(url: ACTIVITY_URL, parameters: params)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getActivityData(url: String, parameters: [String: String]){
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                NSLog("Success! Got the activity data")
                
                let activityJSON : JSON  = JSON(response.result.value!)
                print(activityJSON[0])
                self.updateActivityData(json: activityJSON[0])
                
                
            }
            else {
                //NSLog("Error \(response.result.error)")
                self.activityName.text = "Activity Unavail"
            }
            
        }
    }
    
    func updateActivityData(json : JSON) {
        activityName.text = json["fields"]["name"].stringValue
        activityDescription.text = json["fields"]["description"].stringValue
    }
    
}
