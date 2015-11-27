//
//  CountriesCodesTableViewController.swift
//  Social Network App
//
//  Created by Felix Olivares on 10/6/15.
//  Copyright © 2015 Felix Olivares. All rights reserved.
//

import UIKit

protocol CountriesAndCodesDelegate {
    func codeToVerificationView(code:String)
}

class CountriesCodesTableViewController: UITableViewController {
    
    var allCountries = []
    var myDelegate: CountriesAndCodesDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cc1 : CountriesAndCodes = CountriesAndCodes()
        cc1.country = "United States"
        cc1.code = "+1"
        
        let cc2 : CountriesAndCodes = CountriesAndCodes()
        cc2.country = "Mexico"
        cc2.code = "+52"
        
        allCountries = [cc1, cc2]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCountries.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let cc : CountriesAndCodes = allCountries[indexPath.row] as! CountriesAndCodes
        let countryLabel = cell.viewWithTag(100) as? UILabel
        countryLabel?.text = cc.country
        let codeLabel = cell.viewWithTag(101) as? UILabel
        codeLabel?.text = cc.code

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cc : CountriesAndCodes = allCountries[indexPath.row] as! CountriesAndCodes
        self.myDelegate?.codeToVerificationView(cc.code)
        self.navigationController?.popViewControllerAnimated(true)
    }

    

}
