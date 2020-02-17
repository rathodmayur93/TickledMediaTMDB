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
        
        //Show indicator while loading the image from the url
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.startAnimating()
        if self.image == nil{
            self.addSubview(activityIndicator)
        }
        
        /*
         - Will check whether request url image is available in cache or not
         - If in cache it is available will return the image from cache
         - else will download the image from url and store it in cache
         */
        if let cachedImage = imageCache.object(forKey: urlString as NSString){
            print("Returning Cached Image")
            self.image = cachedImage
            activityIndicator.removeFromSuperview()
        }else{
            
            URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
                
                /*
                  - If error is not nil then will remove the activity indicator
                  - Will show an default image
                  - Else will show an downloaded image
                 */
                if error != nil {
                    print(error ?? "No Error")
                    
                    //Updating the UI on the main thread
                    DispatchQueue.main.async {
                        activityIndicator.removeFromSuperview()
                        self.image = UIImage(named: "noImage")
                    }
                    
                    return
                }
                
                //Updating the image on the main thread
                DispatchQueue.main.async {
                    //Converting the data into the UIImage
                    let image = UIImage(data: data!)
                    //Removing the activity indicator
                    activityIndicator.removeFromSuperview()
                    
                    //Updating the image in imageView
                    guard let loadedImage = image else { return }
                    self.image = loadedImage
                    //Store the image into the cache
                    imageCache.setObject(loadedImage, forKey: urlString as NSString)
                }
                
            }).resume()
        }
    }
}
