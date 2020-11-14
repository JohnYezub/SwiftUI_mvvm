//
//  NewsWidget.swift
//  NewsWidget
//
//  Created by   admin on 13.11.2020.
//

import WidgetKit
import SwiftUI



struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> WidgetContent {
        WidgetContent(date: Date(),title: "Today News title", description: "This is news text. It contains the beginning of some news")
    }

    //data widget displays in widget gallery
    func getSnapshot(in context: Context, completion: @escaping (WidgetContent) -> ()) {
        let entry = WidgetContent(date: Date(),title: "Today News title", description: "This is news text. It contains the beginning of some news")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [WidgetContent] = []
        let w = WidgetContent.readContents()
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset, to: currentDate)!
            let entry = WidgetContent(date: entryDate, title: w[hourOffset].title, description: w[hourOffset].description)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
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
        NewsWidgetEntryView(entry: WidgetContent(date: Date(), title: "test title", description: "test description description description"))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
