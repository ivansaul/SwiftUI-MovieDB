//
//  CachedImageView.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/22/24.
//
//  https://github.com/ivansaul
//

import SwiftUI

struct CachedImageView: View {
    let url: String?
    let type: CacheType

    init(url: String?, type: CacheType = .disk) {
        self.url = url
        self.type = type
    }

    var debug: Bool = false
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay {
                ImageLoader(url: url, type: type)
            }
            .clipped()
    }
}

#Preview {
    CachedImageView(url: Movie.preview.posterUrl)
        .frame(width: 200, height: 200)
}

private struct ImageLoader: View {
    let url: String?
    let type: CacheType
    @ObservedObject var vm: VM

    init(url: String?, type: CacheType = .disk) {
        self.url = url
        self.type = type

        let cacheManager: CacheImageProtocol = {
            switch type {
            case .disk:
                return DiskCacheImageManager.shared
            case .memory:
                return MemoryCacheImageManager.shared
            }
        }()

        let service = Service(cacheManager: cacheManager)
        _vm = ObservedObject(initialValue: VM(url: url, service: service))
    }

    let backgroundColor = Color.theme.primary.blueAccent.opacity(0.3)

    var body: some View {
        Group {
            if vm.isLoading {
                backgroundColor
                    .overlay {
                        ProgressView()
                    }
            } else if let uiImage = vm.uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else if vm.uiImage == nil {
                backgroundColor
                    .overlay {
                        Image(systemName: "photo.on.rectangle.angled")
                    }
            }
        }
        .onChange(of: url) { Task { await vm.loadImage() }}
        .task { await vm.loadImage() }
    }
}

private final class VM: ObservableObject {
    let url: String?
    let service: Service

    init(url: String?, service: Service) {
        self.url = url
        self.service = service
    }

    @Published var isLoading: Bool = true
    @Published var uiImage: UIImage?

    @MainActor
    func loadImage() async {
        defer { isLoading = false }
        guard let url else { return }

        isLoading = true

        do {
            uiImage = try await service.loadImage(url: url)
        } catch {
            uiImage = nil
        }
    }
}

private final class Service: HTTPNetworking {
    let cacheManager: CacheImageProtocol

    init(cacheManager: CacheImageProtocol) {
        self.cacheManager = cacheManager
    }

    func loadImage(url: String) async throws -> UIImage? {
        let key = uniqueID(from: url)

        if let image = cacheManager.get(key: key) {
            return image
        }

        guard let uiImage = try await downloadImage(url: url) else { return nil }
        try cacheManager.save(key: key, value: uiImage)
        return uiImage
    }

    private func downloadImage(url: String) async throws -> UIImage? {
        let resource = ImageResource(url: url)
        let request = try resource.urlRequest()
        let data = try await fetchData(for: request)
        return UIImage(data: data)
    }

    private func uniqueID(from string: String) -> String {
        var hash = UInt64(5381)
        for char in string.utf8 {
            hash = (hash &* 33) &+ UInt64(char)
        }
        return String(format: "%016X", hash)
    }
}
