//
//  Whale.swift
//  FiveSixTwoInterview
//
//  Created by Zach Hanson on 1/26/21.
//

import Foundation

let imageCache = NSCache<NSString, NSData>()
struct Whale: Codable {
    let name: String
    let imageURL: URL
    
    init?(json: [String:Any]) {
        guard let name = json["name"] as? String,
              let imageURLString = json["imageURL"] as? String,
              let imageURL = URL(string: imageURLString)
        else {
            return nil
        }
        self.name = name
        self.imageURL = imageURL
    }
}

extension Whale {
    func fetchImageDataAsync( completion: @escaping (_ imageData: Data?) -> Void) {
        if let cachedData = imageCache.object(forKey: imageURL.absoluteString as NSString) {
            completion(cachedData as Data)
        } else {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageURL) {
                    imageCache.setObject(data as NSData, forKey: imageURL.absoluteString as NSString)
                    completion(data)
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    static func allWhales() -> [Whale] {
        var whales: [Whale] = []
        if let path = Bundle.main.path(forResource: "whales", ofType: "json") {
            do {
                
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                if let json = try? JSONSerialization.jsonObject(with: data) as? [[String:Any]] {
                    for case let whaleData in json {
                        if let whale = Whale(json: whaleData) {
                            whales.append(whale)
                        }
                    }
                }
                
              } catch {
                  return whales
              }
        }
        return whales
        
    }
}

