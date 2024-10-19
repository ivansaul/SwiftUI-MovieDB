//
//  ProfileView.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/18/24.
//
//  https://github.com/ivansaul
//

import SwiftUI

struct ProfileView: View {
    @Environment(AuthViewModel.self) private var authViewModel: AuthViewModel
    var body: some View {
        VStack(spacing: 30.0) {
            if let avatar = authViewModel.currentUser?.avatarURL {
                AsyncImage(url: avatar) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                } placeholder: {
                    loadingProfileImageView
                }
            } else {
                loadingProfileImageView
            }

            if let username = authViewModel.currentUser?.username {
                Text(username)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .foregroundStyle(.white)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }

            Button(action: {
                Task { await authViewModel.signOut() }
            }, label: {
                Text("Sign Out")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            })
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    Task { await authViewModel.fetchAccountDetails() }
                }, label: {
                    Image(systemName: "arrow.clockwise")
                })
            }
        }
        .opacity(authViewModel.isLoading ? 0 : 1)
        .overlay {
            if authViewModel.isLoading {
                ProgressView()
            } else {
                EmptyView()
            }
        }
        .task { await authViewModel.fetchAccountDetails() }
    }
}

#Preview {
    NavigationStack {
        ProfileView()
            .environment(AuthViewModel(authService: MockAuthService()))
    }
}

extension ProfileView {
    private var loadingProfileImageView: some View {
        RoundedRectangle(cornerRadius: 30)
            .frame(width: 100, height: 100)
            .foregroundStyle(.ultraThinMaterial)
    }
}
