//
//  LoadingView.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/28/23.
//

import SwiftUI

struct LoadingView: View {

    var body: some View {
        VStack(alignment: .center) {
            Spacer()

            ProgressView {
                Text("Loading news...")
                    .foregroundColor(.appColor(.tint))
            }

            Spacer()
            Spacer()

        }
    }
}
