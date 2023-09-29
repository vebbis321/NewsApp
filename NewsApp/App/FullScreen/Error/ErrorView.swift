//
//  ErrorView.swift
//  NewsApp
//
//  Created by Vebjørn Daniloff on 9/28/23.
//

import SwiftUI

struct ErrorView: View {
    let error: NewsError
    let retryAction: (() -> Void)?
    var body: some View {
        ZStack {
            Color.appColor(.background)
            VStack(alignment: .center, spacing: 15) {
                Spacer()

                Text("Error")
                Text(error.localizedDescription)

                if let retryAction {
                    Button(action: retryAction) {
                        Text("Retry")
                            .bold()
                            .foregroundColor(.blue)

                    }
                }
                Spacer()
                Spacer()
            }
        }.foregroundColor(.appColor(.tint))
    }
}
