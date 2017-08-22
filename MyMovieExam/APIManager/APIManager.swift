//
//  APIManager.swift
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class APIManager {
    
    // MARK: Custom Variables
    
    typealias ResponseBlock = (_ error: Error?, _ response: BasicModel?) -> Void
    
    // MARK: - GET Methods
    
    @discardableResult static func Get(_ url: String,params:[String:String],loader:Bool, completion: ResponseBlock?) -> DataRequest? {
        if !self.isConnectedToNetwork {
            completion?(ErrorNetwork.offline, nil)
            return nil
        }
        NSLog("API- Method: Get \nRequest url: \(url) \nparameters: \(params)")
        if(loader){
          //  Global.appdel.startSpinerWithOverlay(overlay: true)
        }

        let request = Alamofire.request(url, method: .get, parameters: params, headers: self.header).responseObject { (response:DataResponse<BasicModel>) in
            //Global.appdel.stopSpiner()
                //data is nsdictonary
                let basicmodel = response.result.value
            if(basicmodel != nil){
                completion?(nil, basicmodel)
            }else{
                completion?(ErrorNetwork.serverError, nil)
            }
        }
        
        return request
    }
    
    // MARK: - Other Methods
    static var isConnectedToNetwork: Bool {
        let network = NetworkReachabilityManager()
        return (network?.isReachable)!
    }
    
    static private var header: [String: String] {
        let dictHeader = [String: String]()
        return dictHeader
    }

}

class BasicModel: Mappable {
    var results: [Result]!
    var count: Int?
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        results <- map["results"]
        count <- map["count"]
    }
}

class Result:Mappable{
    var name: String?
    var start_time: String?
    var end_time: String?
    var channel: String?
    var rating: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {

        name <- map["name"]
        start_time <- map["start_time"]
        end_time <- map["end_time"]
        channel <- map["channel"]
        rating <- map["rating"]
        
    }
}
