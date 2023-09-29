//
//  NewsFilterViewModel.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/29/23.
//

import SwiftUI

class NewsFilterViewModel: ObservableObject {
    var sources: [String]
    @Published var selectedSources: Set<String>

    init(
        sources: [String],
        selectedSources: Set<String>
    ) {
        self.sources = sources
        self.selectedSources = selectedSources
    }

    func clearSelection() {
        selectedSources.removeAll()
    }
}
