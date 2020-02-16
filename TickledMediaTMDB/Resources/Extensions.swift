//
//  Extensions.swift
//  TickledMedia
//
//  Created by ds-mayur on 2/12/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import UIKit

fileprivate let imageCache = NSCache<NSString, UIImage>()

extension UIApplication {
    
    // The app's key window taking into consideration apps that support multiple scenes.
    var keyWindowInConnectedScenes: UIWindow? {
        return windows.first(where: { $0.isKeyWindow })
    }
}

extension UIImageView {
    
    func loadImageUsingUrl(urlString : String){
        
        print("Loading Image \(urlString)")
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.startAnimating()
        if self.image == nil{
            self.addSubview(activityIndicator)
        }
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString){
            print("Returning Cached Image")
            self.image = cachedImage
            activityIndicator.removeFromSuperview()
        }else{
            URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
                
                if error != nil {
                    print(error ?? "No Error")
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    let image = UIImage(data: data!)
                    activityIndicator.removeFromSuperview()
                    
                    guard let loadedImage = image else { return }
                    self.image = loadedImage
                    imageCache.setObject(loadedImage, forKey: urlString as NSString)
                })
                
            }).resume()
        }
    }
}
