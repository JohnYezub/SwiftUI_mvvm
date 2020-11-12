//
//  EntryView.swift
//  SwiftUIMVVM
//
//  Created by   admin on 12.11.2020.
//

import SwiftUI

struct NewsWidgetEntryView: View {
    let model: WidgetContent

    var body: some View {
        VStack {
        Text(model.date, style: .time)
        Text(model.newsTitle)
        Text(model.description)
        }
    }
}

