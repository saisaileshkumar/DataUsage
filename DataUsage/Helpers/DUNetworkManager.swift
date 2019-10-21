//
//  DUNetworkManager.swift
//  DataUsage
//
//  Created by Suri,Sai Sailesh Kumar on 20/10/19.
//  Copyright © 2019 Sailesh. All rights reserved.
//

import UIKit

protocol DUNetworkManagerDelegate {
    func didCompleteReceivingConsumptionDetails()
}

class DUNetworkManager: NSObject {
    let serviceUrl: URL = URL.init(string: "https://data.gov.sg/api/action/datastore_search?offset=14&limit=54&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f")!
    private let networkError: DUNetWorkErrors = DUNetWorkErrors()
    var delegate: DUNetworkManagerDelegate?

     /// gets mobile data usage volumes.
     ///
     /// - Parameters:
     ///   - url: url
     ///   - completionHandler: results are returned on successfull or failure of response
     func getMobileDataUsageVolumes(_ url: URL, completionHandler: @escaping (_ result: Any?, _ error: Error?, _ response: HTTPURLResponse) -> Void) {
        print("Request URL: \(url)")
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                if let error = error {
                    debugPrint("error receving reponse: \(error.localizedDescription)")
                    completionHandler(nil, error, response)
                } else {
                    debugPrint("Status Code: \(response.statusCode)")
                    if let data = data, let dataString = String(data: data, encoding: .utf8) {
                        debugPrint("Response:\(dataString)")
                        do {
                            let result = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                            completionHandler(result, error, response)
                        } catch let errorResponse {
                            debugPrint(errorResponse.localizedDescription)
                            completionHandler(nil, error, response)
                        }
                        completionHandler(nil, error, response)
                    }
                }
            }
        }
        task.resume()
    }
    
    /// initiates service call and saves details
    func fetchMobileDataConsumptionVolumeDetails() {
        self.getMobileDataUsageVolumes(serviceUrl) { (result, error, response) in
            if let result = result {
                if let dataResult = result as? [String: Any], let results = dataResult["result"] as? [String: Any]{
                    if let records = results["records"] as? [[String: Any]] {
                        let dataManager = DUDataManager()
                        dataManager.saveDataUsageForOfflineCaching(records)
                        self.delegate?.didCompleteReceivingConsumptionDetails()
                    }
                }
            } else {
                if !self.networkError.checkValidStatusCode(statusCode: response.statusCode) {
                    let title = self.networkError.errorTitle(statusCode: response.statusCode)
                    let message = self.networkError.errorMessage(statusCode: response.statusCode)
                    DispatchQueue.main.async {
                        self.showErrorAlert(title: title, message: message)
                    }
                }
                
            }
        }
    }
    
    /// To displayy Error
    ///
    /// - Parameters:
    ///   - title: title
    ///   - message: message description
    func showErrorAlert(title: String, message: String) {
        let topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
        topWindow?.rootViewController = UIViewController()
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
        topWindow?.makeKeyAndVisible()
        topWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    
}
