//
//  RecommendViewController.swift
//  MuseumCrawlers-Tailwind
//
//  Created by Brad Derstine on 5/6/18.
//  Copyright © 2018 Brad Derstine. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RecommendViewController: UIViewController {

    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var prevGalleryID: UIButton!
    
    @IBOutlet weak var recomArtist: UILabel!
    @IBOutlet weak var recomTitle: UILabel!
    
    let defaults = UserDefaults.standard
    
    let RECOMMEND_URL = "http://museumcrawlers.com/api/gallery/111/recommendation"
    let params : [ String: String ] = ["persona_id" : "1"]
    let rec = RecommendDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let team = defaults.object(forKey: "teamName") as! String
        teamName.text = team
        
        getRecommendData(url: RECOMMEND_URL, parameters: params)
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
    @IBAction func nextRecommendation(_ sender: Any) {
        getRecommendData(url: RECOMMEND_URL, parameters: params)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getRecommendData(url: String, parameters: [String: String]){
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                NSLog("Success! Got the recommendation data")
                
                let recommendJSON : JSON  = JSON(response.result.value!)
                print(recommendJSON[0])
                self.updateRecommendData(json: recommendJSON[0])
                
                
            }
            else {
                //NSLog("Error \(response.result.error)")
                self.recomTitle.text = "Recommendation Unavail"
            }
            
        }
    }
    
    func updateRecommendData(json : JSON) {
        recomTitle.text = json["fields"]["title"].stringValue
        recomArtist.text = json["fields"]["artist"].stringValue
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "reasonRecName") {
//            let vc = segue.destination as! ReasoningViewController
//            vc.prevRecommend = "Your Data"
//        }
//    }
    
}
