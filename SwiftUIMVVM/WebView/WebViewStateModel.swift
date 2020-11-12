//
//  WebViewStateModel.swift
//  SwiftUIMVVM
//
//  Created by   admin on 12.11.2020.
//

import SwiftUI

class WebViewStateModel: ObservableObject {
    @Published var pageTitle: String = "Web View"
    @Published var loading: Bool = false
    @Published var canGoBack: Bool = false
    @Published var goBack: Bool = false
}

