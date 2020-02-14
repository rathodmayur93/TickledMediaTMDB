//
//  Extensions.swift
//  TickledMedia
//
//  Created by ds-mayur on 2/12/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import UIKit

extension UIApplication {

    // The app's key window taking into consideration apps that support multiple scenes.
    var keyWindowInConnectedScenes: UIWindow? {
        return windows.first(where: { $0.isKeyWindow })
    }
}

extension UIImageView {

func loadImageUsingUrl(urlString : String){
    
    print("Loading Image \(urlString)")
    
    DispatchQueue.global().async { [weak self] in
        if let data = try? Data(contentsOf: URL(string: urlString)!) {
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    } 
  }
}
