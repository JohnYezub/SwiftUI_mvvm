//
//  NewsRow.swift
//  SwiftUIMVVM
//
//  Created by   admin on 11.11.2020.
//

import SwiftUI

struct NewsRow: View {
   
    var article: ArticleViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                
                HStack(alignment: .top, spacing: 10) {
                    Text(article.title)
                        .lineLimit(nil)
                        .font(.title2)
                    Spacer()
                    if article.image != nil {
                        Image(uiImage: article.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    }
                }
                .padding(.top)
                .padding(.bottom)
                    
                Text(article.description)
                    .foregroundColor(.secondary)
                    .lineLimit(nil)
                
                HStack(alignment: .firstTextBaseline) {
                    
                    Text(article.sourceName)
                        .foregroundColor(.secondary)
                        .lineLimit(nil)
                    Spacer()
                    if let publishedAt = article.publishedAt {
                    Text(publishedAt)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    }
                }
                .padding(.top)
            }
        }
    }
}

struct NewsRow_Previews: PreviewProvider {
    static var previews: some View {
        NewsRow(article: ArticleListViewModel().articles[0])
            
    }
}
