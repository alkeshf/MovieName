//
//  UserModel.swift
//  TheNew
//
//  Created by Bharat Nakum on 4/17/17.
//  Copyright © 2017 Bharat Nakum. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

internal struct UserModel {
    
}



class MyProfileModel: NSObject,NSCoding,Mappable {
    
    var Id:NSNumber?
    var token: String?
    
    var FirstName: String!
    var LastName: String!
    var email: String?
    var phone: String?
    var photo: String?
    var dob: String?
    var gender: String?
    var user_type: String? // 0 - user,1-driver 2- handyman
    var is_verified:NSNumber = 0
    var wallet:NSNumber = 0
    
    
    required override init() {
    }
    
    required init?(map: Map){
        
        
    }
    
    func mapping(map: Map) {
        Id <- map["id"]
        token <- map["api_token"]
        FirstName <- map["firstname"]
        LastName <- map["lastname"]
        email <- map["email"]
        phone <- map["phone"]
        photo <- map["pic"]
        dob <- map["dob"]
        gender <- map["gender"]
        user_type <- map["user_type"]
        is_verified <- map["is_verified"]
        wallet <- map["wallet"]
        
        
    }
    
    
    // MARK: - Encoding and Decoding Methods
    
    required init(coder decoder: NSCoder) {
        
        Id = decoder.decodeObject(forKey: "Id") as? NSNumber
        token = decoder.decodeObject(forKey: "token") as? String
        FirstName = decoder.decodeObject(forKey: "FirstName") as? String
        LastName = decoder.decodeObject(forKey: "LastName") as? String
        email = decoder.decodeObject(forKey: "email") as? String
        phone = decoder.decodeObject(forKey: "phone") as? String
        photo = decoder.decodeObject(forKey: "photo") as? String
        dob = decoder.decodeObject(forKey: "dob") as? String
        gender = decoder.decodeObject(forKey: "gender") as? String
        user_type = decoder.decodeObject(forKey: "user_type") as? String
        is_verified = (decoder.decodeObject(forKey: "is_verified") as? NSNumber)!
        wallet = (decoder.decodeObject(forKey: "wallet") as? NSNumber)!
        
    }
    
    func encode(with coder: NSCoder) {
        
        coder.encode(Id, forKey: "Id")
        coder.encode(token, forKey: "token")
        coder.encode(FirstName, forKey: "FirstName")
        coder.encode(LastName, forKey: "LastName")
        coder.encode(email, forKey: "email")
        coder.encode(phone, forKey: "phone")
        coder.encode(photo, forKey: "photo")
        coder.encode(dob, forKey: "dob")
        coder.encode(gender, forKey: "gender")
        coder.encode(user_type, forKey: "user_type")
        coder.encode(is_verified, forKey: "is_verified")
        coder.encode(wallet, forKey: "wallet")
        
    }
    
}

