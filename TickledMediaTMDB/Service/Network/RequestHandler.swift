//
//  RequestHandler.swift
//  TickledMediaTMDB
//
//  Created by ds-mayur on 2/14/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import Foundation

class RequestHandler {
    
    func networkResultData<T : Codable>(completion: @escaping ((Result<T, ErrorResult>) -> Void)) -> ((Result<Data, ErrorResult>) -> Void){
        
        return { dataResult in
            
            DispatchQueue.global(qos: .background).async(execute: {
                
                switch dataResult{
                case .success(let data):
                    let movieList = try? JSONDecoder().decode(T.self, from: data)
                    print(movieList!)
                    completion(.success(movieList!))
                case .failure(let error):
                    print("Network Error \(error)")
                    completion(.failure(.network(string: "Network Error " + error.localizedDescription)))
                    break
                }
            })
        }
    }
}
