//
//  passslotInterface.swift
//  append
//
//  Created by Jimmy Kang on 9/11/21.
//

// implementations of methods to create new passslots with

import Foundation
import UIKit

class PSInterface {
    
    // calls the api with the following information and returns the URL
    static func generatePass(whenCompleted: @escaping (String) -> Void, mainText: String, subText: String, barcodeData: String, barcodeText: String? = nil, colorIndex: Int) -> Void {
        print("generating pass with barcodeData: " + barcodeData)
        print("colorIndex: " + colorIndex.description)
        let params = ["mainText": mainText, "subText": subText, "barcodeID": barcodeData, "barcodeText": barcodeText ?? ""] as Dictionary<String, String>
        var request = URLRequest(url: URL(string: "https://api.passslot.com/v1/templates/" + psAccess.templateGreen + "/pass")!)
        let loginString = String(psAccess.username+":")
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let b64login = loginData.base64EncodedString()
        
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(b64login)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        var result: Dictionary<String, AnyObject>? = nil
        var url: String? = nil
        
        print("here")
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                result = json
                url = result?["url"] as? String
                whenCompleted(url!)
                print(json)
            } catch {
                print("error")
            }
        })
        task.resume()
    }
}
