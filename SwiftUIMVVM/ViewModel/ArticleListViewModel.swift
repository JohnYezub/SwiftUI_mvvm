//
//  ArticleListViewModel.swift
//  SwiftUIMVVM
//
//  Created by   admin on 11.11.2020.
//
import Foundation
import Combine
import SwiftUI

class ArticleListViewModel: ObservableObject {
    
    @Published var articles = [ArticleViewModel]()
    
    init() {
        fetchData()
        
    }

    private func fetchData() {
        NetworkService.loadData() { articles in
            if let articles = articles {
                self.articles = articles.map(ArticleViewModel.init)
                self.imagesData()
                let widgetContent = WidgetContent(date: Date(), title: articles[0].title, description: articles[0].description ?? "")
                WidgetContent.writeContents(widgetContent: widgetContent)
            }
        }
    }
    
    private func imagesData(_ index: Int = 0) {
        guard articles.count > index else { return }
        let article = articles[index]
        ImageStore.downloadImageBy(url: article.urlToImage) {
            self.articles[index].image = $0
            self.imagesData(index + 1)
        }
    }
}
