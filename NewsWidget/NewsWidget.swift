//
//  NewsWidget.swift
//  NewsWidget
//
//  Created by   admin on 13.11.2020.
//

import WidgetKit
import SwiftUI



struct Provider: TimelineProvider {
    
    let defaultContent = NewsWidgetContent(date: Date(),title: "Today News title", description: "This is news text. It contains the beginning of some news")
    
    func placeholder(in context: Context) -> NewsWidgetContent {
        defaultContent
    }
    
    //data widget displays in widget gallery
    func getSnapshot(in context: Context, completion: @escaping (NewsWidgetContent) -> ()) {
        completion(defaultContent)
    }
    
    //the main method to produce data and timeline
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        print(#function)
        //initiate date
        var entryDate = Date()
        
        var entries: [NewsWidgetContent] = []
        //get saved contents from shared container
        //var contents = WidgetContent.readContents()
        
        //update contents from Network
        WidgetContent.loadData { (articles) in
            if let articles = articles, articles.count >= 6 {
                print("articles.count: \(articles.count)")

                for i in 0...6 {

                    //generate date for time line
                    entryDate = Calendar.current.date(byAdding: .minute, value: 1, to: entryDate)!
                    
                    //create entry
                    var newsEntry = NewsWidgetContent(date: entryDate, title: articles[i].title, description: articles[i].description ?? "")
                
                    //populate with image if there is some
                    if let urlToImage = articles[i].urlToImage {
                        WidgetContent.downloadImageBy(url: urlToImage) { (image) in
                            newsEntry.image = image
                            print("IMAGE")
                            entries.append(newsEntry)
                            //stupidly check for last value
                            if i == 6 {
                                let timeline = Timeline(entries: entries, policy: .atEnd)
                                print("entries.count")
                                print(entries.count)
                                completion(timeline)
                            }
                        }
                    } else {
                    entries.append(newsEntry)
                        //stupidly check for last value
                        if i == 6 {
                            let timeline = Timeline(entries: entries, policy: .atEnd)
                            completion(timeline)
                        }
                    }
                }
                
            }

        }
        
//Dispay only one news
//                WidgetContent.loadData { (articles) in
//                    if let articles = articles {
//                        var entries: [NewsWidgetContent] = []
//
//                        if let first = articles.first {
//                            entryDate = Calendar.current.date(byAdding: .minute, value: 1, to: entryDate)!
//                            var newsEntry = NewsWidgetContent(date: entryDate, title: first.title, description: first.description ?? "")
//
//                            if let urlToImage = first.urlToImage {
//                            WidgetContent.downloadImageBy(url: urlToImage) { (image) in
//                                newsEntry.image = image
//                                entries.append(newsEntry)
//                                let timeline = Timeline(entries: entries, policy: .after(entryDate))
//                                completion(timeline)
//                            }
//                            } else {
//                            entries.append(newsEntry)
//                            let timeline = Timeline(entries: entries, policy: .after(entryDate))
//                            completion(timeline)
//                            }
//                        }
//                    }
//                }
        

    }
}


@main
struct NewsWidget: Widget {
    let kind: String = "NewsWidget"
    
    var body: some WidgetConfiguration {
        
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            NewsWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("News Widget")
        .description("This is an example of news widget.")
    }
}

struct NewsWidget_Previews: PreviewProvider {
    static var previews: some View {
        NewsWidgetEntryView(entry: NewsWidgetContent(date: Date(), title: "test title", description: "test description description description"))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
