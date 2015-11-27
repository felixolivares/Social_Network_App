//
//  AddressBookVerification.swift
//  Social Network App
//
//  Created by Felix Olivares on 10/5/15.
//  Copyright © 2015 Felix Olivares. All rights reserved.
//

import Foundation

func addressBookRequestPermission() {
    let isRunMoreThanOnce : Bool = NSUserDefaults.standardUserDefaults().boolForKey("isRunMoreThanOnce")
    let isSmsVerified : Bool = NSUserDefaults.standardUserDefaults().boolForKey("isSmsVerified")
    
    if isRunMoreThanOnce{
        print("run more than once")
    }else{
        print("not run more than once")
        if isSmsVerified{
            print("verified by sms")
        }else{
            print("not verified by sms")
        }
    }
    
}