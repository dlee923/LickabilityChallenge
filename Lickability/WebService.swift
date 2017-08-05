//
//  WebService.swift
//  Lickability
//
//  Created by Daniel Lee on 8/3/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import Foundation

class WebService {

    private let baseURL = "http://jsonplaceholder.typicode.com/photos"
    
    func downloadObjectsAsJson(completion: @escaping ([[Swatch]]) -> ()) {
        
        var tempAlbumId = 0
        var albumIdArray = [Swatch]()
        var swatchArray = [[Swatch]]()
        
        guard let url = URL(string: self.baseURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
            }
            
            guard let downloadedData = data else { return }
            
            let json = try? JSONSerialization.jsonObject(with: downloadedData, options: .mutableContainers)
            
            if let objects = json as? [AnyObject] {
                
                for object in objects {
                    if let albumId = object["albumId"] as? Int,
                        let id = object["id"] as? Int,
                        let title = object["title"] as? String,
                        let url = object["url"] as? String,
                        let thumbnailUrl = object["thumbnailUrl"] as? String {
                        
                        if albumId != tempAlbumId {
                            if albumIdArray.count > 0 {
                                swatchArray.append(albumIdArray)
                            }
                            albumIdArray.removeAll()
                            tempAlbumId = albumId
                        }
                        
                        let swatch = Swatch(albumId: albumId, id: id, title: title, url: url, thumbnailUrl: thumbnailUrl)                        
                        albumIdArray.append(swatch)
                    }
                }
                DispatchQueue.main.async {
                    completion(swatchArray)
                }
            }
        }.resume()
    }
}
