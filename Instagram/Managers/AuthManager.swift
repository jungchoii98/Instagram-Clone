//
//  AuthManager.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import FirebaseAuth
import Foundation

protocol AuthManagerProtocol {
    var isSignedIn: Bool { get }
    func signIn(
        email: String,
        password: String,
        completion: @escaping (Result<IGUser,AuthManager.AuthError>) -> Void
    )
    func signUp(
        email: String,
        password: String,
        username: String,
        profileImage: Data?,
        completion: @escaping (Result<IGUser,AuthManager.AuthError>) -> Void
    )
    func signOut(completion: @escaping (Bool) -> Void)
}

final class AuthManager: AuthManagerProtocol {
    
    static let shared = AuthManager()
    
    private init() {}
    
    private let auth = FirebaseAuth.Auth.auth()
    
    var isSignedIn: Bool {
        return auth.currentUser != nil ? true : false
    }
    
    func signIn(
        email: String,
        password: String,
        completion: @escaping (Result<IGUser, AuthManager.AuthError>) -> Void
    ) {
        
    }
    
    public func signUp(
        email: String,
        password: String,
        username: String,
        profileImage: Data?,
        completion: @escaping (Result<IGUser, AuthManager.AuthError>) -> Void
    ) {
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                completion(.failure(.createUserError))
                return
            }
            let user = IGUser(username: username, email: email)
            DatabaseManager.shared.createUser(user: user) { didSucceed in
                if didSucceed {
                    StorageManager.shared.uploadProfilePicture(
                        username: username,
                        pictureData: profileImage
                    ) { pictureDidUpload in
                        if pictureDidUpload {
                            completion(.success(user))
                        } else {
                            completion(.failure(.uploadProfilePictureError))
                        }
                    }
                } else {
                    completion(.failure(.createUserError))
                }
            }
        }
    }
    
    func signOut(completion: @escaping (Bool) -> Void) {
        
    }
}

extension AuthManager {
    enum AuthError: Error {
        case createUserError
        case uploadProfilePictureError
    }
}
