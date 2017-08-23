//
//  Global.swift
//  SwiftDemo
//
//  Created by  Alkesh on 02/03/2015.
//  Copyright (c) 2016 Alkesh. All rights reserved.

import UIKit

struct Global {
    
    // API base Url
    static let g_APIBaseURL = "https://www.whatsbeef.net/wabz/"
    static let appdel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    //Device Compatibility
    struct is_Device {
        static let _iPhone = (UIDevice.current.model as NSString).isEqual(to: "iPhone") ? true : false
        static let _iPad = (UIDevice.current.model as NSString).isEqual(to: "iPad") ? true : false
        static let _iPod = (UIDevice.current.model as NSString).isEqual(to: "iPod touch") ? true : false
        
    }
    //IOS Version Compatibility
    struct is_Ios {
        static let _9 = ((UIDevice.current.systemVersion as NSString).floatValue >= 9.0) ? true : false
        static let _8 = ((UIDevice.current.systemVersion as NSString).floatValue >= 8.0 && (UIDevice.current.systemVersion as NSString).floatValue < 9.0) ? true : false
        static let _7 = ((UIDevice.current.systemVersion as NSString).floatValue >= 7.0 && (UIDevice.current.systemVersion as NSString).floatValue < 8.0) ? true : false
        static let _6 = ((UIDevice.current.systemVersion as NSString).floatValue <= 6.0 ) ? true : false
    }
    
    //Display Size Compatibility
    struct is_Iphone {
        static let _6p = (UIScreen.main.bounds.size.height >= 736.0 ) ? true : false
        static let _6 = (UIScreen.main.bounds.size.height <= 667.0 && UIScreen.main.bounds.size.height > 568.0) ? true : false
        static let _5 = (UIScreen.main.bounds.size.height <= 568.0 && UIScreen.main.bounds.size.height > 480.0) ? true : false
        static let _4 = (UIScreen.main.bounds.size.height <= 480.0) ? true : false
    }
    
    
    struct   local {
        static let LocalDocument = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
   
    struct APIURL {
        
        static let guide = "\(g_APIBaseURL)guide.php"
    }
    
    
 
    
    
}

