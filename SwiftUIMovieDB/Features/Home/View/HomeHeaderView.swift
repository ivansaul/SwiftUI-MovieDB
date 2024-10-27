//
//  HomeHeaderView.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/19/24.
//
//  https://github.com/ivansaul
//

import SwiftUI

struct HomeHeaderView: View {
    let user: User
    var body: some View {
        HStack {
            CachedImageView(url: user.avatarURL?.absoluteString)
                .frame(width: 40, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            VStack(alignment: .leading) {
                Text("Hello, \(user.username)")
                    .textStyle(.h4(color: .theme.text.white, weight: .semibold))
                Text("Let’s stream your favorite movie")
                    .textStyle(.h6(color: .theme.text.grey, weight: .medium))
            }
            Spacer()
        }
    }
}

#Preview {
    HomeHeaderView(user: User.preview)
}
