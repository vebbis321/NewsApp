//
//  FilterView.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/28/23.
//

import SwiftUI

struct NewsFilterView: View {
    @ObservedObject var viewModel: NewsFilterViewModel

    var body: some View {

        Form {
            ForEach(viewModel.sources, id: \.self) { source in
                HStack {
                    Text(source)
                    Spacer()

                    Image(systemName: "checkmark")
                        .foregroundColor(.green)
                        .opacity(viewModel.selectedSources.contains(source) ? 1 : 0)

                }
                .contentShape(Rectangle())
                .onTapGesture {
                    if viewModel.selectedSources.contains(source) {
                        viewModel.selectedSources.remove(source)
                    } else {
                        viewModel.selectedSources.insert(source)
                    }

                }
            }
        }
        .listStyle(.plain)
        .padding(.bottom, 20)
    }
}
