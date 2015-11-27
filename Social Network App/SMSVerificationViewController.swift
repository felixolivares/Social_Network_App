//
//  SMSVerificationViewController.swift
//  Social Network App
//
//  Created by Felix Olivares on 10/5/15.
//  Copyright © 2015 Felix Olivares. All rights reserved.
//

import UIKit
import CoreTelephony

class SMSVerificationViewController: UIViewController, UITextFieldDelegate, CountriesAndCodesDelegate {

    @IBOutlet weak var sendButton: UIBarButtonItem!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var countryCodeTextField: UITextField!
    
    var countryCode : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundColor = UIColor(rgb: 0xf2f3ef)
        self.view.backgroundColor = backgroundColor
        
        sendButton.enabled = false
        sendButton.tintColor = UIColor(rgb: 0xCCCCCC)
        
        let networkInfo = CTTelephonyNetworkInfo()
        let carrier = networkInfo.subscriberCellularProvider
        let mcc = carrier?.mobileCountryCode
        
        print("Carrier: \(carrier!) - MCC: \(mcc!)")
        switch mcc!{
            case "334":
                countryCode = "+52"
            case "310", "311", "312", "313", "316":
                countryCode = "+1"
            default:
                countryCode = ""
        }
        
        countryCodeTextField.text = countryCode
        
        let tap = UITapGestureRecognizer.init(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func dismissKeyboard() {
        phoneNumberTextField.resignFirstResponder()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        sendButton.enabled = true
        let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        let components = newString.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
        
        let decimalString : String = components.joinWithSeparator("")
        let length = decimalString.characters.count
        let decimalStr = decimalString as NSString
        let hasLeadingOne = length > 0 && decimalStr.characterAtIndex(0) == (1 as unichar)
        
        if length == 0 || (length > 10 && !hasLeadingOne) || length > 11
        {
            let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
            
            return (newLength > 10) ? false : true
        }
        var index = 0 as Int
        let formattedString = NSMutableString()
        
        if hasLeadingOne
        {
            formattedString.appendString("1 ")
            index += 1
        }
        if (length - index) > 3
        {
            let areaCode = decimalStr.substringWithRange(NSMakeRange(index, 3))
            formattedString.appendFormat("(%@)", areaCode)
            index += 3
        }
        if length - index > 3
        {
            let prefix = decimalStr.substringWithRange(NSMakeRange(index, 3))
            formattedString.appendFormat("%@-", prefix)
            index += 3
        }
        
        let remainder = decimalStr.substringFromIndex(index)
        formattedString.appendString(remainder)
        textField.text = formattedString as String
        return false
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == countryCodeTextField{
            self.performSegueWithIdentifier("countriesAndCodesSegue", sender: self)
            return false
        }else {
            return true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "countriesAndCodesSegue" {
            let countriesCodeVC = segue.destinationViewController as? CountriesCodesTableViewController
            if let viewController = countriesCodeVC {
                viewController.myDelegate = self
            }
        }
    }
    
    func showTableWithCountryCodes(){
        
    }
    
    //MARK: Delegate method - Country & Code
    func codeToVerificationView(code:String){
        countryCode = code
        countryCodeTextField.text? = countryCode
    }
}
