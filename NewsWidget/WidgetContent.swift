//
//  WidgetContent.swift
//  SwiftUIMVVM
//
//  Created by   admin on 13.11.2020.
//

import WidgetKit
import SwiftUI

class WidgetImage: ObservableObject {
    @Published var widgetimage: Image = WidgetContent.readImage()!
}

struct WidgetContent: TimelineEntry, Codable {
    var date = Date()
    let title: String
    let description: String
}

extension WidgetContent {
    
    static func writeImage(image: UIImage) {
        if let archiveURL = FileManager.sharedContainerURL() {
           let url = archiveURL.appendingPathComponent("widgetImage.png")
            print("writeImage: \(url)")
            guard let data = image.pngData() else { return }            
            do {
                try data.write(to: url)
            } catch {
                print("Error saving image file ")
            }

        }
    }
    
    static func readImage() -> Image? {
        if let archiveURL = FileManager.sharedContainerURL() {
           let url = archiveURL.appendingPathComponent("widgetImage.png")
            print("readImage: \(url)")
            if FileManager.default.fileExists(atPath: url.path) {
                print("Image found!")
                let img = Image(url.path)
                return img
            } else {
                print("Error reading image file ")
            }
        }
        return nil
    }
        
   static func writeContents(widgetContent: WidgetContent) {
        if let archiveURL = FileManager.sharedContainerURL() {
           let url = archiveURL.appendingPathComponent("contents")
            print("writeContents: \(url)")
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        if let data = try? encoder.encode(widgetContent) {
            do {
                try data.write(to: url)
            } catch {
                print("Error: Can't write contents")
                return
            }
        }
        }
    }
    
   static func readContents() -> WidgetContent? {
        if let archiveURL = FileManager.sharedContainerURL() {
        let url = archiveURL.appendingPathComponent("contents")
        let decoder = PropertyListDecoder()
        do {
            let data = try Data(contentsOf: url)
            return try decoder.decode(WidgetContent.self, from: data)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
        }
        return nil
    }
}

extension FileManager {
    static func sharedContainerURL() -> URL? {
        return FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: "group.EvgenyEzub.SwiftUIMVVM.contents"
        )
    }
}
