//
//  Utils.swift
//  MazaganShowCase
//
//  Created by Nabil Sossey Alaoui on 5/3/17.
//  Copyright © 2017 B4E. All rights reserved.
//

import Foundation

class Utils {


    static func getSyncDataFromUrl(url: String, httpMethod: String, parameter: String) -> Any? {
        
        

        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = httpMethod
        let postString = parameter
        
        request.httpBody = postString.data(using: .utf8)
        
        var success:(Any)? = nil
        
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { Data, response, error in
            if let error = error {
                print("Error while trying to re-authenticate the user: \(error)")
            } else if let response = response as? HTTPURLResponse,
                300..<600 ~= response.statusCode {
                print("Error while trying to re-authenticate the user, statusCode: \(response.statusCode)")
            } else {
                success = try! JSONSerialization.jsonObject(with: Data!, options: .allowFragments)
            }
            semaphore.signal()
        })
            
        task.resume()
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        
        return success
       
    }
    



}
