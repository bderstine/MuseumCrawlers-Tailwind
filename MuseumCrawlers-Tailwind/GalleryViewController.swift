//
//  GalleryViewController.swift
//  MuseumCrawlers-Tailwind
//
//  Created by Brad Derstine on 5/6/18.
//  Copyright © 2018 Brad Derstine. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var galleryID: UILabel!
    @IBOutlet weak var galleryName: UILabel!
    
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let team = defaults.object(forKey: "teamName") as! String
        teamName.text = team
        
        //This is digusting, will need to update and pull from the recommendation engine by the event
        defaults.set("visited", forKey: "didFirstGallery")
        let something = defaults.object(forKey: "didFirstGallery") as! String
        NSLog(something)
        
//        if let something2 = defaults.object(forKey: "didFirstGallery") as? String {
//            let gID = defaults.object(forKey: "firstGalleryNum") as! String
//            let gName = defaults.object(forKey: "firstGalleryName") as! String
//            galleryID.text = gID
//            galleryName.text = gName
//        } else {
//            let gID = defaults.object(forKey: "secondGalleryNum") as! String
//            let gName = defaults.object(forKey: "secondGalleryName") as! String
//            galleryID.text = gID
//            galleryName.text = gName
//        }
        
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

}
