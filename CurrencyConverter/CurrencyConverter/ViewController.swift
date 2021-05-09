//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Pelin ASLAN on 9.05.2021.
//


import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var myCurrency:[String] = []
    var myValues:[Double] = []
    
    var activeCurrency:Double = 0;

    
    //Objects
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var outputLabel: UILabel!
    
    //CREATING PICKER VIEW
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return myCurrency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return myCurrency[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        activeCurrency = myValues[row]
    }
    
    
    
    //BUTTON
    @IBAction func convertClicked(_ sender: Any) {
        
        if (inputText.text != "")
        {
            let txt = String(Double(inputText.text!)! * activeCurrency)
            outputLabel.text = "-> Converted: \(txt)"
        }
        
        
    }
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //GETTING DATA
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=fbb279168ec53b5484b5c64702f7b739")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil
            {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                if data != nil
                {
                    do
                    {
                        let myJson = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        //ASYNC
                        DispatchQueue.main.async
                        {
                            if let rates = myJson["rates"] as? NSDictionary
                            {
                                for (key, value) in rates
                                {
                                    self.myCurrency.append((key as? String)!)
                                    self.myValues.append((value as? Double)!)
                                }
                            }
                        }
                    }
                    catch
                    {
                     print("error")
                    }
                }
            }
            self.pickerView.reloadAllComponents()
        }
        
        task.resume()
    }
    
    
    
    override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
          // Dispose of any resources that can be recreated.
      }



}


