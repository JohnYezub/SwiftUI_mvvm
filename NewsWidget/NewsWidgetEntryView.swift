//
//  WidgetView.swift
//  SwiftUIMVVM
//
//  Created by   admin on 13.11.2020.
//

import SwiftUI

// View of widget
struct NewsWidgetEntryView : View {
   // var entry: Provider.Entry
    var entry: WidgetContent
    //let model: WidgetContent
    @Environment(\.widgetFamily) var widgetFamily
    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            VStack {
                Text(entry.title)
                    .font(.subheadline)
                    .lineLimit(nil)
            }
            .padding()
            
        case .systemMedium:
            VStack {
                Text(entry.title)
                    .font(.title3)
                    .lineLimit(nil)
                    .padding(.bottom, 10)
                Text(entry.description)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    .lineLimit(nil)
            }
            .padding()
            
        default:
            VStack {
                Text(entry.title)
                    .font(.title3)
                    .lineLimit(nil)
                    .padding(.bottom, 10)
                Text(entry.description)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    .lineLimit(nil)
            }
            .padding()
        }
        
    }
}




struct NewsWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        let entry = WidgetContent(title: "News Title", description: "Text text text text text text...")
        NewsWidgetEntryView(entry: entry)
    }
}
