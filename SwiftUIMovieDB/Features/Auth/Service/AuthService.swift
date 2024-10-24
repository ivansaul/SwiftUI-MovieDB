//
//  AuthService.swift
//  SwiftUIMovieDB
//
//  Created by @ivansaul on 10/18/24.
//
//  https://github.com/ivansaul
//

import AuthenticationServices
import Foundation

class AuthService: NSObject, HTTPNetworking, AuthServiceProtocol {
    private let keychainManager: KeychainProtocol = KeychainManager()

    func signInWithTMDB() async throws {
        let requestToken = try await getRequestToken()
        let approvedRequestToken = try await webAuth(requestToken: requestToken)
        let sessionID = try await getSessionID(approvedRequestToken: approvedRequestToken)
        keychainManager.set(sessionID, forKey: APIConstants.Keys.sessionID)
    }

    func signOut() async throws {
        keychainManager.delete(APIConstants.Keys.sessionID)
    }

    func authStatus() async -> AuthStatus {
        keychainManager.get(key: APIConstants.Keys.sessionID) == nil
            ? .loggedOut
            : .loggedIn
    }
}

extension AuthService: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        DispatchQueue.main.sync {
            ASPresentationAnchor()
        }
    }
}

// SIGN IN BASIC WORKFLOW
//
// References:
//
// https://developer.themoviedb.org/reference/authentication-how-do-i-generate-a-session-id
// https://developer.themoviedb.org/v4/docs/authentication-user
//
// 1. Generate a new [request token]
// 2. Send the user to TMDB asking the user to approve the token
// 3. With an [approved request token], generate a [fresh access token]
//
//
// - Step 1: Create a request token(REQUEST_TOKEN) [GET]
//   https://api.themoviedb.org/3/authentication/token/new
//
// - Step 2: Ask the user for permission
//   https://www.themoviedb.org/authenticate/{REQUEST_TOKEN}?redirect_to=http://www.yourapp.com/approved
//
// - Step 3: Create a session ID [POST]
//   https://api.themoviedb.org/3/authentication/session/new

extension AuthService {
    // STEP 1: Create a request token(REQUEST_TOKEN) [GET]
    private func getRequestToken() async throws -> String {
        let resource = AuthResource()
        let request = try resource.urlRequest()
        let data = try await fetchData(for: request)
        let decodedData = try decodeData(as: AuthRequestTokenModel.self, data: data)
        return decodedData.requestToken
    }

    // STEP 2: Ask the user for permission
    private func webAuth(requestToken: String) async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            asWebAuth(requestToken: requestToken) { result in
                switch result {
                    case .success(let value):
                        continuation.resume(returning: value)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                }
            }
        }
    }

    // STEP 3: Create a session ID [POST]
    private func getSessionID(approvedRequestToken: String) async throws -> String {
        let resource = AuthSessionIDResource(requestToken: approvedRequestToken)
        let request = try resource.urlRequest()
        let data = try await fetchData(for: request)
        let decodedData = try decodeData(as: AuthSessionIDModel.self, data: data)
        return decodedData.sessionId
    }

    private func asWebAuth(requestToken: String, completion: @escaping (Result<String, Error>) -> Void) {
        // Scheme is required for the redirect again to the app
        let scheme = APIConstants.movieDBUrlScheme

        // https://www.themoviedb.org/authenticate/{REQUEST_TOKEN}?redirect_to=http://www.yourapp.com/approved
        let urlString = APIConstants.movieDBUrl + APIConstants.Auth.authenticate + "/" + "\(requestToken)?redirect_to=\(scheme)://auth"

        guard let authURL = URL(string: urlString) else {
            completion(.failure(NetworkingError.badURL))
            return
        }

        // Create the ASWebAuthenticationSession with the URL and the callback URL scheme
        // ASWebAuthenticationSession shows the browser for the user to approve the request token
        let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: scheme) { callbackURL, error in
            guard let callbackURL, error == nil else {
                completion(.failure(AuthError.canceled))
                return
            }

            let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems

            // Check if the user denied the request login
            guard ((queryItems?.filter { $0.name == "denied" }.first?.value) != nil) == false else {
                completion(.failure(AuthError.denied))
                return
            }

            // Get the approved request token (session id)
            let token: String? = queryItems?.filter { $0.name == "request_token" }.first?.value
            guard let token else {
                completion(.failure(AuthError.denied))
                return
            }

            completion(.success(token))
        }
        session.presentationContextProvider = self
        session.start()
    }
}
