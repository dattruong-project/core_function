//
//  PaymentByZl.swift
//  Runner
//
//  Created by Truong Dat on 17/08/2023.
//

import Foundation
import zpdk

func GetCurrentDateInFormatYYMMDD() -> String {
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "yyMMdd"
   return dateFormatterPrint.string(from:Date())
}

class PaymentByZl {
    init(){
        ZaloPaySDK.sharedInstance().initWithAppId(2554, uriScheme: "payment://core", environment: .sandbox)
    }
    
    static let instance = PaymentByZl()
    

    func payment() {
        let currentDate = Date()
        let random = Int.random(in: 0...10000000)
       
        let appTransPrefix = GetCurrentDateInFormatYYMMDD()

        let appTransID = "\(appTransPrefix)_\(random)"
      
        let appId = 2554
        let appUser = "demo"
        let appTime = Int(currentDate.timeIntervalSince1970*1000)
        let embedData = "{}"
        let item = "[]"
        let description = "Merchant payment for order #" + appTransID
        
        let hmacInput = "\(appId)" + "|" + "\(appTransID)" + "|" + appUser + "|" + "\(200)" + "|" + "\(appTime)" + "|"
        + embedData + "|" + item
        
        let mac = hmacInput.hmac(algorithm: CryptoAlgorithm.SHA256, key: "sdngKKJmqEMzvh5QQcdD2A9XBSKUNaYn")//2554 sb
        
        var request = HttpProvider.instance.request!
        request.httpMethod = "POST"

        let postString = "app_id=\(appId)&app_user=\(appUser)&app_time=\(appTime)&amount=\(20000)&app_trans_id=\(appTransID)&embed_data=\(embedData)&item=\(item)&description=\(description)&mac=\(mac)"
        request.httpBody = postString.data(using: .utf8)
        DispatchQueue.main.async {
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    return // check for fundamental networking error
                }

                // Getting values from JSON Response
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(String(describing: responseString))")
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? NSDictionary
                    let returncode =  jsonResponse?.object(forKey: "return_code") as? Int
                    if returncode != 1{
                       
                    } else {
                        let zptranstoken = jsonResponse?.object(forKey: "zp_trans_token") as? String
                        
                    }
                } catch _ {
                    print ("OOps not good JSON formatted response")
                }
            }
            task.resume()
        }
    }
}
