//
//  LoginView.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/18/24.
//
//  https://github.com/ivansaul
//

import SwiftUI

struct LoginView: View {
    @Environment(AuthViewModel.self) private var authViewModel
    var body: some View {
        @Bindable var authViewModel = authViewModel
        ZStack {
            // Background Color
            Color.theme.primaryDark
                .ignoresSafeArea()

            // Content
            content
                .padding(.horizontal)
        }
        .alert("", isPresented: $authViewModel.showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(authViewModel.errorMessage)
        }
    }
}

#Preview {
    LoginView()
        .environment(AuthViewModel(authService: MockAuthService()))
}

extension LoginView {
    private var content: some View {
        VStack(spacing: 20.0) {
            Image(.tmdbLogo)
                .resizable()
                .scaledToFit()
                .frame(width: 150)

            Text("Sign in or create a FREE account")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(Color.theme.textGrey)

            Text("Join now to subscribe to your favorite shows, like episodes, follow friends, create custom playlists, and discover so much more!")
                .textStyle(.h5(color: .theme.textDarkGrey, weight: .semibold))
                .padding(.bottom, 20)

            Button(action: {
                Task { await authViewModel.signIn() }
            }, label: {
                Text("Sign in with TMDM")
                    .textStyle(.h4(color: .theme.textWhite, weight: .semibold))
                    .padding()
                    .background(Color.theme.primaryBlueAccent)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            })
            .disabled(authViewModel.isLoading ? true : false)
            .opacity(authViewModel.isLoading ? 0.5 : 1.0)
        }
        .multilineTextAlignment(.center)
    }
}
