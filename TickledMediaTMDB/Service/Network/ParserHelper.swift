//
//  ParserHelper.swift
//  TickledMediaTMDB
//
//  Created by ds-mayur on 2/16/20.
//  Copyright © 2020 Mayur Rathod. All rights reserved.
//

import Foundation

protocol Parceable {
    static func parseObject(T : Codable) -> Result<Self, ErrorResult>
}

final class ParserHelper {
    
    /*
    static func parse<T: Codable>(data: Data, completion : (Result<T, ErrorResult>) -> Void) {
        
        do {
            
            let movieList = try JSONDecoder().decode(T.self, from: data) {
                
                // init final result
                // check foreach dictionary if parseable
                switch T.parseObject(dictionary: dictionary) {
                case .failure(let error):
                    completion(.failure(error))
                    break
                case .success(let newModel):
                    completion(.success(newModel))
                    break
                }
                
                
            }
        } catch {
            // can't parse json
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
 */
}
