//
//  CategoriesFilterView.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/24/24.
//
//  https://github.com/ivansaul
//

import SwiftUI

struct CategoriesFilterView: View {
    @State private var currentIndex: Int = 0

    @Namespace private var namespace

    let categories: [String]

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(categories.indices, id: \.self) { index in
                    ZStack {
                        if currentIndex == index {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.theme.primary.soft)
                                .matchedGeometryEffect(id: "ID", in: namespace)
                        }

                        Text(categories[index])
                            .textStyle(
                                .h5(
                                    color: currentIndex == index ?
                                        .theme.primary.blueAccent :
                                        .theme.text.white,
                                    weight: .medium
                                )
                            )
                            .padding(.horizontal, 20)
                    }
                    .frame(height: 40)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            currentIndex = index
                        }
                    }
                }
            }
        }
        .scrollIndicators(.never)
    }
}

#Preview {
    CategoriesFilterView(categories: .previewCategories)
}

extension [String] {
    static var previewCategories: [String] {
        [
            "All", "Comedy", "Animation", "Action",
        ]
    }
}
