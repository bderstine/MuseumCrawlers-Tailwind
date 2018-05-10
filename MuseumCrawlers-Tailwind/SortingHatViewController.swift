//
//  SortingHatViewController.swift
//  MuseumCrawlers-Tailwind
//
//  Created by Brad Derstine on 5/6/18.
//  Copyright © 2018 Brad Derstine. All rights reserved.
//

import UIKit

struct Question {
    var Question: String!
    var Answers: [String]!
}

extension UIView {
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
}

class SortingHatViewController: UIViewController {
    
    //@IBOutlet weak var QLabel: UILabel!
    @IBOutlet var Buttons: [UIButton]!
    
    let defaults = UserDefaults.standard
    var Questions = [Question]()
    var QNumber = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Questions = [
            //0
            Question(Question: "Reading OR Painting?", Answers: ["Reading","Painting"]),
            //1
            Question(Question: "Hiking OR Meditation?", Answers: ["Hiking","Meditation"]),
            //2
            Question(Question: "Running on the beach\nOR\nSipping drinks on the beach", Answers: ["Running on the beach","Sipping drinks on the beach"]),
            //3
            Question(Question: "Studying a cure for a disease\nOR\nVisiting ruins in the Jungle ", Answers: ["Studying a cure for a disease","Visiting ruins in the Jungle"]),
            //4
            Question(Question: "Understanding the Entire Universe\nOR\nObserving the Big Bang", Answers: ["Understanding the Entire Universe","Observing the Big Bang"]),
            //5
            Question(Question: "Travelling to distant stars\nOR\nMeeting an alien race", Answers: ["Travelling to distant stars","Meeting an alien race"]),
            //6
            Question(Question: "Talking to Picasso\nOR\nTalking to Abraham Lincoln", Answers: ["Talking to Picasso","Talking to Abraham Lincoln"]),
            //7
            Question(Question: "Fighting in the civil war\nOR\nHelping Da Vinci build flying machines", Answers: ["Fighting in the civil war","Helping Da Vinci build flying machines"]),
            //8
            Question(Question: "Taking acid with Salvador Dali\nOR\nDrinking wine with the Pope", Answers: ["Taking acid with Salvador Dali","Drinking wine with the Pope"]),
            //9
            Question(Question: "Going to a buddhist temple\nOR\nStudying a urinal at PMA", Answers: ["Going to a buddhist temple","Studying a urinal at PMA"]),
            //10
            Question(Question: "Are you here ALONE\nOR\nWITH A GROUP (2 or more)?", Answers: ["Alone","With a group"])
        ]
        
        PickQuestion(pq: 0)
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 52, height: 52))
        let img = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.green.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            let rectangle = CGRect(x: 0, y: 0, width: 52, height: 52)
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
    }
    
    func PickQuestion(pq:Int){
        QNumber = pq
        //QLabel.text = Questions[QNumber].Question
        for i in 0..<Buttons.count{
            Buttons[i].setTitle(Questions[QNumber].Answers[i], for: UIControlState.normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Btn1(_ sender: Any) {
        //        NSLog("Button 1 Pressed!")
        //        NSLog(Buttons[0].titleLabel!.text!)
        //        NSLog(String(QNumber))
        saveQuestionFeedback(pq:QNumber,answer:Buttons[0].titleLabel!.text!)
    }
    
    @IBAction func Btn2(_ sender: Any) {
        //        NSLog("Button 2 Pressed!")
        //        NSLog(Buttons[1].titleLabel!.text!)
        //        NSLog(String(QNumber))
        saveQuestionFeedback(pq:QNumber,answer:Buttons[1].titleLabel!.text!)
    }
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    func saveQuestionFeedback(pq:Int,answer:String){
        if pq == 0 {
            resetDefaults()
            
            defaults.set(answer, forKey: "firstAnswer")
            defaults.set(true, forKey: "didFirstAnswer")
            
            PickQuestion(pq:1)
        }
        else if pq == 1 {
            defaults.set(answer, forKey: "secondAnswer")
            defaults.set(true, forKey: "didSecondAnswer")
            
            let firstAnswer = defaults.object(forKey: "firstAnswer") as! String
            let secondAnswer = defaults.object(forKey: "secondAnswer") as! String
            
            if firstAnswer=="Reading" && secondAnswer=="Hiking" {
                PickQuestion(pq:2)
            }
            else if firstAnswer=="Reading" && secondAnswer=="Meditation" {
                PickQuestion(pq:4)
            }
            else if firstAnswer=="Painting" && secondAnswer=="Hiking" {
                PickQuestion(pq:6)
            }
            else if firstAnswer=="Painting" && secondAnswer=="Meditation" {
                PickQuestion(pq:8)
            }
        }
        else if pq == 10 {
            defaults.set(answer, forKey: "fifthAnswer")
            //NSLog("Redirect to results viewcontroller!")
            performSegue(withIdentifier: "ViewResults", sender: nil)
        }
        else{
            let firstAnswer = defaults.object(forKey: "firstAnswer") as! String
            let secondAnswer = defaults.object(forKey: "secondAnswer") as! String
            let didThirdAnswer = defaults.bool(forKey: "didThirdAnswer")
            
            if didThirdAnswer == true {
                defaults.set(answer, forKey: "fourthAnswer")
                defaults.set(true, forKey: "didFourthAnswer")
                defaults.synchronize()
                PickQuestion(pq:10)
            }
            else{
                defaults.set(answer, forKey: "thirdAnswer")
                defaults.set(true, forKey: "didThirdAnswer")
                defaults.synchronize()
                
                if firstAnswer=="Reading" && secondAnswer=="Hiking" {
                    PickQuestion(pq:3)
                }
                else if firstAnswer=="Reading" && secondAnswer=="Meditation" {
                    PickQuestion(pq:5)
                }
                else if firstAnswer=="Painting" && secondAnswer=="Hiking" {
                    PickQuestion(pq:7)
                }
                else if firstAnswer=="Painting" && secondAnswer=="Meditation" {
                    PickQuestion(pq:9)
                }
                
            }
            
        }
        
    }
}

