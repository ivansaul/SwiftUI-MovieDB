//
//  CarouselView.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/21/24.
//
//  https://github.com/ivansaul
//

import Combine
import SwiftUI

struct CarouselView<Item: Identifiable, Content: View>: View {
    let items: [Item]
    let content: (Item) -> Content

    let spacing: Double
    let sidesScaling: Double
    let itemInset: Double
    let autoplay: Bool
    let duration: Double

    @Binding var selectedIndex: Int
    @State private var dragOffset: Double = .zero
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private let swipeThreshold: Double = 10.0

    init(
        items: [Item],
        spacing: Double = 40.0,
        sidesScaling: Double = 0.85,
        itemInset: Double = 40.0,
        autoplay: Bool = false,
        duration: Double = 5.0,
        selectedIndex: Binding<Int>,
        @ViewBuilder content: @escaping (Item) -> Content
    ) {
        self.items = items
        self.content = content
        self.spacing = spacing
        self.sidesScaling = sidesScaling
        self.itemInset = itemInset
        self.autoplay = autoplay
        self.duration = duration
        self._selectedIndex = selectedIndex
    }

    var body: some View {
        GeometryReader { proxy in
            let cardWidth = proxy.size.width - itemInset * 2
            let cardHeight = proxy.size.height
            ZStack {
                ForEach(items.indices, id: \.self) { index in
                    content(items[index])
                        .frame(width: cardWidth, height: cardHeight)
                        .offset(x: (cardWidth + spacing) * Double(index))
                        .offset(x: -(cardWidth + spacing) * Double(selectedIndex))
                        .scaleEffect(index == selectedIndex ? 1 : sidesScaling)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    dragOffset = value.translation.width
                                }
                                .onEnded { _ in
                                    withAnimation(.spring()) {
                                        let validDrag = abs(dragOffset) > swipeThreshold
                                        if dragOffset < 0, validDrag {
                                            selectedIndex = min(items.count - 1, selectedIndex + 1)
                                        }
                                        if dragOffset > 0, validDrag {
                                            selectedIndex = max(0, selectedIndex - 1)
                                        }
                                    }
                                }
                        )
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .onAppear { setupTimer() }
            .onChange(of: autoplay) { setupTimer() }
            .onChange(of: duration) { setupTimer() }
            .onReceive(timer, perform: { _ in
                withAnimation(.spring()) {
                    if selectedIndex < items.count - 1 {
                        selectedIndex += 1
                    } else {
                        selectedIndex = 0
                    }
                }

            })
        }
    }

    private func setupTimer() {
        timer.upstream.connect().cancel()
        if autoplay, duration > 0 {
            timer = Timer.publish(every: duration, on: .main, in: .common).autoconnect()
        }
    }
}

struct CarouselDemoView: View {
    @State var selectedIndex: Int = 1
    @State var spacing: Double = 40.0
    @State var sidesScaling: Double = 0.85
    @State var itemInset: Double = 40.0
    @State var autoplay: Bool = false
    @State var duration: Double = 2.0

    let items: [Movie] = .preview

    var body: some View {
        VStack {
            CarouselView(items: items, spacing: spacing, sidesScaling: sidesScaling, itemInset: itemInset, autoplay: autoplay, duration: duration, selectedIndex: $selectedIndex) { movie in
                CachedImageView(url: movie.posterUrl)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
            }
            .frame(height: 400)

            ControlPanel(spacing: $spacing, slidesScaling: $sidesScaling, itemInset: $itemInset, autoplay: $autoplay, duration: $duration)

            Spacer()
        }
        .padding(.top)
    }
}

#Preview {
    CarouselDemoView()
}

private struct ControlPanel: View {
    @Binding var spacing: Double
    @Binding var slidesScaling: Double
    @Binding var itemInset: Double
    @Binding var autoplay: Bool
    @Binding var duration: Double

    var body: some View {
        VStack {
            Group {
                HStack {
                    Text("spacing: ").frame(width: 120)
                    Slider(value: $spacing, in: 0...50, minimumValueLabel: Text("0"), maximumValueLabel: Text("50")) { EmptyView() }
                }
                HStack {
                    Text("ItemInset: ").frame(width: 120)
                    Slider(value: $itemInset, in: 0...100, minimumValueLabel: Text("0"), maximumValueLabel: Text("100")) { EmptyView() }
                }
                HStack {
                    Text("sidesScaling: ").frame(width: 120)
                    Slider(value: $slidesScaling, in: 0...1, minimumValueLabel: Text("0"), maximumValueLabel: Text("1")) { EmptyView() }
                }
                VStack {
                    HStack {
                        Toggle(isOn: $autoplay, label: {
                            Text("autoScroll: ").frame(width: 120)
                        })
                    }
                    if autoplay {
                        HStack {
                            Text("duration: ").frame(width: 120)
                            Slider(value: $duration, in: 1...10, minimumValueLabel: Text("1"), maximumValueLabel: Text("10")) { EmptyView() }
                        }
                    }
                }
            }
        }
        .padding([.horizontal, .top])
    }
}
