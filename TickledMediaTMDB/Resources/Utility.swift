//
//  UiUtility.swift
//  TickledMedia
//
//  Created by ds-mayur on 2/12/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import UIKit

struct Utility {
    
    //Loader Views
    static let spinningActivityIndicator: UIActivityIndicatorView  = UIActivityIndicatorView()
    static let container: UIView                                   = UIView()
    
    //MARK: Converting the hex color codes into the UIColor
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    //MARK: Show Indicator Loader while making an api call
    static func showIndicatorLoader(){
        
        let window                      = UIApplication.shared.keyWindowInConnectedScenes
        container.frame                 = UIScreen.main.bounds
        container.backgroundColor       = UIColor(hue: 0/360, saturation: 0/100, brightness: 0/100, alpha: 0.4)
        
        let loadingView: UIView         = UIView()
        loadingView.frame               = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center              = container.center
        loadingView.backgroundColor     = UIColor.gray
        loadingView.clipsToBounds       = true
        loadingView.layer.cornerRadius  = 40
        
        spinningActivityIndicator.frame                         = CGRect(x: 0, y: 0, width: 40, height: 40)
        spinningActivityIndicator.hidesWhenStopped              = true
        spinningActivityIndicator.style  = UIActivityIndicatorView.Style.large
        spinningActivityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(spinningActivityIndicator)
        container.addSubview(loadingView)
        window?.addSubview(container)
        spinningActivityIndicator.startAnimating()
    }
    
    //MARK:- Hide loader when receive the response form the api call
    static func hideIndicatorLoader(){
        DispatchQueue.main.async {
            self.spinningActivityIndicator.stopAnimating()
            self.container.removeFromSuperview()
        }
    }
    
    //MARK: Read JSON from the local file
    static func readJson(fileName : String) -> Data? {
        
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                //Creating the URL from Path
                let fileUrl = URL(fileURLWithPath: path)
               
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                
                return data
                
            } catch {
                /*
                  - Handle error here
                  - Invalid json format
                */
                
            }
        }
        
        return nil
    }
    
    //MARK:- Fetching the errorMessage from teh ErrorResult Enum property
    static func retrieveErrorMessage(errorResult : ErrorResult) -> String{
        
        switch errorResult{
        case .custom(let value):
            return value
        case .network(let value):
            return value
        case .parser(let value):
            return value
        default:
            return "We are facing some technical issue. Please try again after sometime"
        }
    }
}
