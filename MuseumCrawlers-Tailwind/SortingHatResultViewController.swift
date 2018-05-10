//
//  SortingHatResultViewController.swift
//  MuseumCrawlers-Tailwind
//
//  Created by Brad Derstine on 5/6/18.
//  Copyright © 2018 Brad Derstine. All rights reserved.
//

import UIKit

class SortingHatResultViewController: UIViewController {
    
    @IBOutlet weak var Result: UILabel!
    @IBOutlet weak var TeamDescription: UILabel!
    
    let defaults = UserDefaults.standard
    var results = [String: Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        processResults()
    }
    
    
    func processResults(){
        let firstAnswer = defaults.object(forKey: "firstAnswer") as! String
        let secondAnswer = defaults.object(forKey: "secondAnswer") as! String
        let thirdAnswer = defaults.object(forKey: "thirdAnswer") as! String
        let fourthAnswer = defaults.object(forKey: "fourthAnswer") as! String
        //let fifthAnswer = defaults.object(forKey: "fifthAnswer") as! String
        
        if firstAnswer=="Reading"{
            addResult(res: "Scholar")
        }
        else{
            addResult(res: "Creative")
        }
        
        if secondAnswer=="Hiking" {
            addResult(res: "Adventurer")
        }
        else{
            addResult(res: "Spiritualist")
        }
        
        switch thirdAnswer {
        case "Running on the beach":
            addResult(res: "Adventurer")
        case "Sipping drinks on the beach":
            addResult(res: "Scholar")
        case "Understanding the Entire Universe":
            addResult(res: "Spiritualist")
        case "Observing the Big Bang":
            addResult(res: "Scholar")
        case "Talking to Picasso":
            addResult(res: "Creative")
        case "Talking to Abraham Lincoln":
            addResult(res: "Adventurer")
        case "Taking acid with Salvador Dali":
            addResult(res: "Creative")
        case "Drinking wine with the Pope":
            addResult(res: "Spiritualist")
        default:
            NSLog(thirdAnswer)
        }
        
        switch fourthAnswer {
        case "Studying a cure for a disease":
            addResult(res: "Scholar")
        case "Visiting ruins in the Jungle":
            addResult(res: "Adventurer")
        case "Travelling to distant stars":
            addResult(res: "Scholar")
        case "Meeting an alien race":
            addResult(res: "Spiritualist")
        case "Fighting in the civil war":
            addResult(res: "Adventurer")
        case "Helping Da Vinci build flying machines":
            addResult(res: "Creative")
        case "Going to a buddhist temple":
            addResult(res: "Spiritualist")
        case "Studying a urinal at PMA":
            addResult(res: "Creative")
        default:
            NSLog(fourthAnswer)
        }
        
        let finalAnswer = results.max { a, b in a.value < b.value }
        let finalAnswerText = finalAnswer?.key
        defaults.set(finalAnswerText, forKey: "teamName")
        
        defaults.set("Gallery 111", forKey: "firstGalleryNum")
        defaults.set("American Art", forKey: "firstGalleryName")
        defaults.set("Gallery 116", forKey: "secondGalleryNum")
        defaults.set("American Art", forKey: "secondGalleryName")
        
        Result.text = finalAnswerText
        switch finalAnswerText {
        case "Adventurer":
            TeamDescription.text = "You are bold and inquisitive, wanting to explore the world and all its hidden secrets."
        case "Creative":
            TeamDescription.text = "You are curious and insightful, your mind showing you details and perspectives that others miss."
        case "Spiritualist":
            TeamDescription.text = "You are present in the world, seeking not mere facts, but connections and deeper truths."
        case "Scholar":
            TeamDescription.text = "You are thoughtful and focused, curious about \"hows\" and \"whys\" where others see only \"whats.\""
        default:
            NSLog(finalAnswerText!)
        }
        
    }
    
    func addResult(res: String){
        if results[res] == nil {
            results[res] = 1
        } else {
            results[res]! += 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "WayfinderSG") {
            let vc = segue.destination as! WayfindingViewController
            //vc.someGallery.name = "Your Data"
        }
    }
    
}
