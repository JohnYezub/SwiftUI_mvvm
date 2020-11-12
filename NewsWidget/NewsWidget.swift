//
//  NewsWidget.swift
//  NewsWidget
//
//  Created by   admin on 12.11.2020.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> WidgetContent {
       WidgetContent(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (WidgetContent) -> ()) {
        let entry = WidgetContent(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [WidgetContent] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = WidgetContent(date: entryDate, configuration: configuration)
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
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            NewsWidgetEntryView(model: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        //modify your widget to provide only that size
        //.supportedFamilies([.systemMedium])
    }
}

struct NewsWidget_Previews: PreviewProvider {
    static var previews: some View {
        NewsWidgetEntryView(model: WidgetContent(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
