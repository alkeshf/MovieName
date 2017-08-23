//
//  StaticClass.swift
//  SwiftDemo
//
//  Created by  Alkesh on 02/03/2015.
//  Copyright (c) 2016 Alkesh. All rights reserved.
//

import UIKit
import AJNotificationView

class StaticClass {
    
    static let sharedInstance: StaticClass = { StaticClass() }()
    
    // MARK: - Save to NSUserdefault
    func saveToUserDefaults (value: AnyObject?, forKey key: NSString) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key as String)
        defaults.synchronize()
    }
    
    func retriveFromUserDefaults (key: NSString) -> AnyObject? {
        let defaults = UserDefaults.standard
        if(defaults.value(forKey: key as String) != nil){
            print(defaults.value(forKey: key as String) as Any)
        }else{
            return "" as AnyObject?
        }
        
        return defaults.value(forKey: key as String) as AnyObject?
    }
    
    // MARK: - Validation
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailText = NSPredicate(format:"SELF MATCHES [c]%@",emailRegex)
        return (emailText.evaluate(with: email))
    }
    
    
    
    /*func removeTimeFromDate (date: NSDate) -> NSDate {
     let calendarObj: NSCalendar = NSCalendar.autoupdatingCurrentCalendar()
     
     let dateComponentsObj = calendarObj.components([.NSDayCalendarUnit, .NSMonthCalendarUnit, .NSYearCalendarUnit] , fromDate: date)
     dateComponentsObj.hour = 00
     dateComponentsObj.minute = 00
     dateComponentsObj.second = 00
     
     return calendarObj.dateFromComponents(dateComponentsObj)! as NSDate
     }
     
     func getMonthFromDate (date: NSDate) -> Int {
     let components = NSCalendar.currentCalendar().components([.Hour, .Minute, .Month, .Year, .Day], fromDate: date)
     return components.month as Int
     }
     
     func getYearFromDate (date: NSDate) -> NSInteger {
     let components = NSCalendar.currentCalendar().components([.Hour, .Minute, .Month, .Year, .Day], fromDate: date)
     return components.year as NSInteger
     }
     */
    // MARK: - General Methods
    func removeNull (str:String) -> String {
        if (str == "<null>" || str == "(null)" || str == "N/A" || str == "n/a" || str.isEmpty) {
            return ""
        } else {
            return str
        }
    }
    
    func setPrefixHttp (str:NSString) -> NSString {
        if (str == "" || str .hasPrefix("http://") || str .hasPrefix("https://")) {
            return str
        } else {
            let http:NSString = "http://"
            return http.appending(str as String) as NSString
        }
    }
    
    func isconnectedToNetwork() -> Bool {
        /* let reachability = Reachability.reachabilityForInternetConnection()
         
         if !reachability.isReachable() {
         AlertView().showAlertWithOKButton(self.setLocalizeText("keyInternetConnectionError"), withType: AJNotificationTypeRed)
         }
         
         return reachability.isReachable()*/
        return true
    }
    
    
    func shownotifications(message:String) -> Void {
        AJNotificationView.show(in: Global.appdel.window, type: AJNotificationTypeRed, title:"", message: message, hideAfter: 0.5, offset: 0, disclosureType: AJDisclosureTypeNone, disclosureResponse: {
            
        },notificationResponse: {
            
        })
    }
    
    func shownotificationsGreen(message:String) -> Void {
        AJNotificationView.show(in: Global.appdel.window, type: AJNotificationTypeGreen, title:"", message: message, hideAfter: 1, offset: 0, disclosureType: AJDisclosureTypeNone, disclosureResponse: {
            
        },notificationResponse: {
            
        })
    }
    
    
    func checkNull(str:AnyObject) -> String {
        if str is String
        {
            return str as! String
        }
        else {
            return ""
        }
    }
    
    
    
    func getUIColorFromRBG (R rVal: CGFloat, G gVal: CGFloat, B bVal: CGFloat) -> UIColor {
        return UIColor(red: rVal/255.0, green: gVal/255.0, blue: bVal/255.0, alpha: 1.0)
    }
    
    func getUIColorFromRBGAlpha (R rVal: CGFloat, G gVal: CGFloat, B bVal: CGFloat, Alpha alpha: CGFloat) -> UIColor {
        return UIColor(red: rVal/255.0, green: gVal/255.0, blue: bVal/255.0, alpha: alpha)
    }
    
    func getSizeFromString (str: NSString, stringWidth width: CGFloat, fontname font: UIFont, minimumHeight minHeight: CGFloat) -> CGSize {
        
        let height: CGFloat = 100000
        let labelBounds: CGRect = str.boundingRect(with: CGSize(width: width, height: height), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : font], context: nil) as CGRect
        
        if(labelBounds.size.height < minHeight) {
            return CGSize(width:CGFloat(ceilf(Float(labelBounds.size.width))), height: minHeight)
        }
        
        return CGSize(width:CGFloat(ceilf(Float(labelBounds.size.width))),height: CGFloat(ceilf(Float(labelBounds.size.height))))
    }
    
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func loadFromNibNamed(nibNamed: String) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: Bundle.main
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    
    func colorWithHexString (hex:String,alpha:CGFloat) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
        
    }
    
    
    
    func get2DecimalPoint(percent:Double) -> Double {
        let numberOfPlaces = 2.0
        let multiplier = pow(10.0, numberOfPlaces)
        let num = percent
        let roundPer = round(Double(percent) * Double(multiplier)) / Double(multiplier)
        return roundPer;
    }
    
    func getNibName(name:String) -> String {
        let _iPad = (UIDevice.current.model as NSString).isEqual(to: "iPad") ? true : false
        if(_iPad){
            return "\(name)~iPad"
        }else{
            return name
        }
    }
    
    
    func setupCenterButton(button: UIButton) {
        let spacing: CGFloat = 2.0
        let imageSize: CGSize = button.imageView!.image!.size
        button.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(imageSize.height + spacing), 0.0)
        let labelString = NSString(string: button.titleLabel!.text!)
        let titleSize = labelString.size(attributes: [NSFontAttributeName: button.titleLabel!.font])
        button.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, -titleSize.width)
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0;
        button.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 0.0, edgeOffset, 0.0)
    }
    
    
    
    func getPlaceholderImage(gender:String) -> UIImage {
        if(gender == "2"){
            //female
            return UIImage(named: "woman")!
        }else{
            //male
            return UIImage(named: "man")!
        }
    }
    
    func convertToDictionary(text: String) -> NSDictionary {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
            } catch {
                print(error.localizedDescription)
            }
        }
        return NSDictionary()
    }
    
    func getSideBarWidth()->CGFloat{
        if(Global.is_Iphone._6p){
            return 350
        }else if(Global.is_Iphone._6){
            return 310
        }else{
            return 260
        }
    }
    
    
    func StringToDate(stringDate:String,formate:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate //Your date format
        let date = dateFormatter.date(from: stringDate) //according to date format your date string
        return date!
    }
    
    func DateToString(date:Date,formate:String) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = formate
        let now = dateformatter.string(from: date)
        return now
    }
    
    func ConvertServerDateTimeToString(stringDate:String) -> String {
        let dobDate  = self.StringToDate(stringDate: stringDate, formate: "yyyy-MM-dd HH:mm:ss")
        let strDate  = self.DateToString(date:  dobDate , formate: "MMM dd, yyyy")
        return strDate
    }
    
    func ConvertServerDateToString(stringDate:String) -> String {
        let dobDate  = self.StringToDate(stringDate: stringDate, formate: "yyyy-MM-dd")
        let strDate  = self.DateToString(date:  dobDate , formate: "MMM dd, yyyy")
        return strDate
    }
    
    func ConvertStringToServerDate(stringDate:String) -> String {
        let dobDate  = self.StringToDate(stringDate: stringDate, formate: "MMM dd, yyyy")
        let strDate  = self.DateToString(date:  dobDate , formate: "yyyy-MM-dd")
        return strDate
    }
    
    
    
}


