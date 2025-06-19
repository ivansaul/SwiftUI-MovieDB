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
    let items: [Genre]

    @Binding var selectedItem: Genre
    @Namespace private var namespace

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(items) { item in
                    ZStack {
                        if selectedItem == item {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.theme.primary.soft)
                                .matchedGeometryEffect(id: "ID", in: namespace)
                        }

                        Text(item.name)
                            .textStyle(
                                .h5(
                                    color: selectedItem == item ?
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
                            selectedItem = item
                        }
                    }
                }
            }
        }
        .scrollIndicators(.never)
    }
}

#Preview {
    CategoriesFilterView(items: .preview, selectedItem: .constant(.all))
}

extension [String] {
    static var previewCategories: [String] {
        [
            "All", "Comedy", "Animation", "Action",
        ]
    }
}
