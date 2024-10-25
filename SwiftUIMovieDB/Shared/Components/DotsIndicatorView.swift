//
//  DotsIndicatorView.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/24/24.
//
//  https://github.com/ivansaul
//

import SwiftUI

struct DotsIndicatorView: View {
    @Binding var selectedIndex: Int

    let dotsCount: Int
    let dotSize: Double
    let dotSelectedSize: Double
    let dotSpacing: Double
    let dotColor: Color
    let dotSelectedColor: Color
    let visibleDotCount: Int

    init(
        selectedIndex: Binding<Int>,
        dotsCount: Int,
        dotSize: Double = 7.0,
        dotSelectedSize: Double = 10.0,
        dotSpacing: Double = 10.0,
        dotColor: Color = .theme.primary.blueAccent.opacity(0.5),
        dotSelectedColor: Color = .theme.primary.blueAccent,
        visibleDotCount: Int = 5
    ) {
        self._selectedIndex = selectedIndex
        self.dotsCount = dotsCount
        self.dotSize = dotSize
        self.dotSelectedSize = dotSelectedSize
        self.dotSpacing = dotSpacing
        self.dotColor = dotColor
        self.dotSelectedColor = dotSelectedColor
        self.visibleDotCount = visibleDotCount
    }

    var body: some View {
        ScrollView(.horizontal) {
            ScrollViewReader { proxy in
                HStack(spacing: dotSpacing) {
                    ForEach(0 ..< dotsCount, id: \.self) { index in
                        Circle()
                            .fill(index == selectedIndex ? dotSelectedColor : dotColor)
                            .frame(
                                width: getDotSizeAt(index: index),
                                height: getDotSizeAt(index: index)
                            )
                            .id(index)
                            .onTapGesture {
                                print(index)
                                withAnimation(.spring()) {
                                    selectedIndex = index
                                }
                            }
                    }
                    .onChange(of: selectedIndex) { _, newValue in
                        proxy.scrollTo(newValue, anchor: .center)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .scrollDisabled(true)
        .frame(width: getFrameSize())
    }
}

extension DotsIndicatorView {
    private func getDotSizeAt(index: Int) -> Double {
        if index == selectedIndex {
            return dotSelectedSize
        }
        let factorDotSize = dotSize / dotSelectedSize
        let factorIndex = 1.0 / Double(abs(selectedIndex - index))
        return dotSelectedSize * factorDotSize * factorIndex
    }

    private func getFrameSize() -> Double {
        var frame = 0.0
        var range = 0 ..< visibleDotCount

        let threshold: Int = visibleDotCount / 2

        if selectedIndex <= visibleDotCount {
            range = 0 ..< visibleDotCount
        }

        if selectedIndex > threshold, selectedIndex < dotsCount - threshold - 1 {
            range = selectedIndex - threshold ..< selectedIndex + threshold + 1
        }

        if selectedIndex >= dotsCount - threshold - 1 {
            range = dotsCount - visibleDotCount ..< dotsCount
        }

        for i in range {
            frame += getDotSizeAt(index: i)
        }
        return frame + (Double(visibleDotCount - 1) * dotSpacing)
    }
}

struct DotsIndicatorPreview: View {
    @State private var selectedIndex: Int = 0
    private let dotsCount: Int = 40
    var body: some View {
        VStack {
            DotsIndicatorView(selectedIndex: $selectedIndex, dotsCount: dotsCount)

            HStack {
                Button("PREV") {
                    withAnimation(.spring()) {
                        selectedIndex = max(0, selectedIndex - 1)
                    }
                }

                Button("NEXT") {
                    withAnimation(.spring()) {
                        selectedIndex = min(dotsCount - 1, selectedIndex + 1)
                    }
                }
            }
            .buttonStyle(.bordered)

            Text("SelectedINDEX: \(selectedIndex)")
        }
    }
}

#Preview {
    DotsIndicatorPreview()
}
