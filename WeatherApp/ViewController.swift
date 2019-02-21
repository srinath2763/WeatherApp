//
//  ViewController.swift
//  WeatherApp
//
//  Created by IMCS2 on 2/16/19.
//  Copyright © 2019 IMCS2. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var input: UITextField!
    var myHTMLString: String = ""
    var descriptionItem:String  = ""
    @IBOutlet weak var toDisplay: UITextView!
    
    
    @IBAction func submit(_ sender: Any) {
        let myURL = URL(string:"https://api.openweathermap.org/data/2.5/weather?q=\(input.text!)&APPID=805b30fde10ce27df135e4566e9f0b8e")
        print("here")
        let task = URLSession.shared.dataTask(with: myURL!){ (data,response,error) in
            print("?")

                if let unrappedData = data{
                    
                    do{
                       
                        let jsonResult = try JSONSerialization.jsonObject(with: unrappedData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                        print(jsonResult)
                        let weather = jsonResult?["weather"] as? NSArray
                        let weatherItem = weather?[0] as? NSDictionary
                       self.toDisplay.text = weatherItem?["description"] as! String
                        print("description \(self.descriptionItem)")
                       

                    }
                    catch{
                        print("error")
                    }
                }
            
        }
        task.resume()

        }
        
       
            
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        assignbackground()
        print("\(myHTMLString)")
        
    }
    private func processWebsite(_ content: String) -> String{
        var output: [String] = content.components(separatedBy: "<p class=\"b-forecast__table-description-content\"><span class=\"phrase\">")
        let noFoundString = "No Data has been Found"
        if output.indices.contains(1) {
            output = output[1].components(separatedBy: "</span></p></td>")
            if output.indices.contains(1) {
                return output[0].replacingOccurrences(of: "&deg;", with: "deg ")
            }
        }
        return noFoundString
    }
    
    func assignbackground(){
        let background = UIImage(named: "weather")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    

}

