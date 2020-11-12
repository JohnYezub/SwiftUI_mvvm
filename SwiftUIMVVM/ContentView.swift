//
//  ContentView.swift
//  SwiftUIMVVM
//
//  Created by   admin on 11.11.2020.
//

import SwiftUI

//struct MainApp: App {
//    @StateObject private var model: ArticleListViewModel = ArticleListViewModel()
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView(model: model)
//        }
//    }
//}


struct ContentView : View {
    
   @EnvironmentObject var model: ArticleListViewModel
    
    var body: some View {
        
        NavigationView {
            
            List(model.articles) { article in
                NavigationLink(
                    destination: NewsDetailed(url: article.urlWeb)) {
                NewsRow(article: article)
                }
            }
            .navigationTitle(Text("News for today"))
        }
    }
    
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ArticleListViewModel())
    }
}

