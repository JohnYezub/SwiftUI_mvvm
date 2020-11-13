//
//  WebService.swift
//  SwiftUIMVVM
//
//  Created by   admin on 11.11.2020.
//

import Foundation
import UIKit
import SwiftUI

class NetworkService {
    
    static func loadData(completion: @escaping ([Article]?) -> ()) {
        
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=d090b36e7ffd4f38ad37c0c93942a8d6"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data, error == nil {
                
                let response = try? JSONDecoder().decode(JSONModel.self, from: data)
                if let response = response {
                    DispatchQueue.main.async {
                        completion(response.articles)
                    }
                }
            } else {
                print("Error in: \(#function)")
                completion(nil)
            }
        }
        task.resume()
        
    }
    
}

final class ImageStore {
//    typealias _ImageDictionary = [String: CGImage]
//    fileprivate var images: _ImageDictionary = [:]
//
//    fileprivate static var scale = 2
//
//    static var shared = ImageStore()
//
//    //provide Image from Store
//    func image(name: String) -> Image {
//        let index = _guaranteeImage(name: name)
//
//        return Image(images.values[index], scale: CGFloat(ImageStore.scale), label: Text(name))
//    }
//
    static func downloadImageBy(url: String, completion: @escaping (UIImage)->Void) {
        
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, error == nil {
                if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
                }
            }
        }
        task.resume()
    }

//    //load image
//    static func loadImage(name: String) -> CGImage {
//        guard
//            let url = Bundle.main.url(forResource: name, withExtension: "jpg"),
//            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
//            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
//        else {
//            fatalError("Couldn't load image \(name).jpg from main bundle.")
//        }
//        return image
//    }
//    
//    //find Image by name
//    fileprivate func _guaranteeImage(name: String) -> _ImageDictionary.Index {
//        if let index = images.index(forKey: name) { return index }
//        
//        images[name] = ImageStore.loadImage(name: name)
//        return images.index(forKey: name)!
//    }
}
