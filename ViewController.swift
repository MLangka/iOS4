//
//  ViewController.swift
//  iOS4-Langka
//
//  Created by Metawee Langka on 12.12.17.
//  Copyright © 2017 Metawee Langka. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var eurToUsdRate: UITextField!
    @IBOutlet weak var eurToGbpRate: UITextField!
    
    @IBOutlet weak var eurAmount: UITextField!
    @IBOutlet weak var usdAmount: UITextField!
    @IBOutlet weak var gbpAmount: UITextField!
    
    var eurToUsdDouble = 1.1883
    var eurToGbpDouble = 0.881
    
    var eurAmountDouble = 0.0
    var usdAmountDouble = 0.0
    var gbpAmountDouble = 0.0
    
    
    @IBAction func convertFromEur(_ sender: Any) {
        // Get user input
        guard let _inputE = eurAmount.text else {
            return
        }
        eurAmountDouble = Double(_inputE) ?? eurAmountDouble
        
        // Calculate the currencies
        usdAmountDouble = eurAmountDouble * eurToUsdDouble
        gbpAmountDouble = eurAmountDouble * eurToGbpDouble
        
        // Update all input fields
        let euroString = String(format: "%.2lf", eurAmountDouble)
        eurAmount.text = "\(euroString)"
        let usdString = String(format: "%.2lf", usdAmountDouble)
        usdAmount.text = "\(usdString)"
        let gbpString = String(format: "%.2lf", gbpAmountDouble)
        gbpAmount.text = "\(gbpString)"
        
    }
    
    @IBAction func convertFromUsd(_ sender: Any) {
        guard let _inputU = usdAmount.text else {
            return
        }
        usdAmountDouble = Double(_inputU) ?? usdAmountDouble

        eurAmountDouble = usdAmountDouble * (1/eurToUsdDouble)
        gbpAmountDouble = eurAmountDouble * eurToGbpDouble
        
        let euroString = String(format: "%.2lf", eurAmountDouble)
        eurAmount.text = "\(euroString)"
        let usdString = String(format: "%.2lf", usdAmountDouble)
        usdAmount.text = "\(usdString)"
        let gbpString = String(format: "%.2lf", gbpAmountDouble)
        gbpAmount.text = "\(gbpString)"
        
    }
    
    @IBAction func convertFromGbp(_ sender: Any) {
        guard let _inputG = gbpAmount.text else {
            return
        }
        gbpAmountDouble = Double(_inputG) ?? gbpAmountDouble
        
        eurAmountDouble = gbpAmountDouble * (1/eurToGbpDouble)
        usdAmountDouble = eurAmountDouble * eurToUsdDouble
        
        let euroString = String(format: "%.2lf", eurAmountDouble)
        eurAmount.text = "\(euroString)"
        let usdString = String(format: "%.2lf", usdAmountDouble)
        usdAmount.text = "\(usdString)"
        let gbpString = String(format: "%.2lf", gbpAmountDouble)
        gbpAmount.text = "\(gbpString)"
        
    }
    
    @IBAction func updateCurrency(_ sender: Any) {
        // Read from URL
        let usdURL = URL(string: "https://finance.google.com/finance/converter?a=1&from=EUR&to=USD")
        let usdCurrencyString = try! String(contentsOf: usdURL!, encoding: .isoLatin1)
        
        //Search for a string after "1 EUR = <span class=bld>"
        if let range1 = usdCurrencyString.range(of: "1 EUR = <span class=bld>"){
            let subString1 = String(usdCurrencyString.suffix(from: range1.upperBound))
            guard let currentUsd = Double(subString1.prefix(6)) else{
                return
            }
            // Update exchange rate and input fields
            eurToUsdDouble = currentUsd
            eurToUsdRate.text = "\(eurToUsdDouble)"
            usdAmountDouble = eurAmountDouble * eurToUsdDouble
            let usdString = String(format: "%.2lf", usdAmountDouble)
            usdAmount.text = "\(usdString)"
        }
        
        let gbpURL = URL(string: "https://finance.google.com/finance/converter?a=1&from=EUR&to=GBP")
        let gbpCurrencyString = try! String(contentsOf: gbpURL!, encoding: .isoLatin1)
        
        if let range2 = gbpCurrencyString.range(of: "1 EUR = <span class=bld>"){
            let subString2 = String(gbpCurrencyString.suffix(from: range2.upperBound))
            guard let currentGbp = Double(subString2.prefix(6)) else{
                return
            }
            eurToGbpDouble = currentGbp
            eurToGbpRate.text = "\(eurToGbpDouble)"
            gbpAmountDouble = eurAmountDouble * eurToGbpDouble
            let gbpString = String(format: "%.2lf", gbpAmountDouble)
            gbpAmount.text = "\(gbpString)"
        }
    }
    
    // Set EUR to USD rate
    @IBAction func eurToUsd(_ sender: Any) {
        if let _input = eurToUsdRate.text{
            eurToUsdDouble = Double(_input) ?? eurToUsdDouble
        }
        eurToUsdRate.text = "\(eurToUsdDouble)"
        
        usdAmountDouble = eurAmountDouble * eurToUsdDouble
        
        let usdString = String(format: "%.2lf", usdAmountDouble)
        usdAmount.text = "\(usdString)"
        let gbpString = String(format: "%.2lf", gbpAmountDouble)
        gbpAmount.text = "\(gbpString)"
    }
    
    // Set EUR to GBP rate
    @IBAction func eurToGbp(_ sender: Any) {
        if let _input = eurToGbpRate.text{
            eurToGbpDouble = Double(_input) ?? eurToGbpDouble
        }
        eurToGbpRate.text = "\(eurToGbpDouble)"
        
        gbpAmountDouble = eurAmountDouble * eurToGbpDouble
        
        let usdString = String(format: "%.2lf", usdAmountDouble)
        usdAmount.text = "\(usdString)"
        let gbpString = String(format: "%.2lf", gbpAmountDouble)
        gbpAmount.text = "\(gbpString)"
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        eurToUsdRate.text = "\(eurToUsdDouble)"
        eurToGbpRate.text = "\(eurToGbpDouble)"
        
        let euroString = String(format: "%.2lf", eurAmountDouble)
        eurAmount.text = "\(euroString)"
        let usdString = String(format: "%.2lf", usdAmountDouble)
        usdAmount.text = "\(usdString)"
        let gbpString = String(format: "%.2lf", gbpAmountDouble)
        gbpAmount.text = "\(gbpString)"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

