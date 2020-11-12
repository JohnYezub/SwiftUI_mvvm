//
//  WebViewView.swift
//  SwiftUIMVVM
//
//  Created by   admin on 12.11.2020.
//

import SwiftUI

struct WebViewView: View {
    @ObservedObject var webViewStateModel: WebViewStateModel = WebViewStateModel()
    var url: String
    var body: some View {
        if let URL = URL(string: url) {
        WebView(url: URL, webViewStateModel: self.webViewStateModel)
        }
    }
}

struct WebViewView_Previews: PreviewProvider {
    static var previews: some View {
        WebViewView(url: "https://www.google.com")
    }
}
