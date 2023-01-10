//
//  RefreshTokenViewModel.swift
//  MarvelVsDC
//
//  Created by Ankit Panchal on 08/01/23.
//

import Foundation

class RefreshTokenViewModel {
    
    var isSuccess: Dynamic<Bool> = Dynamic(true)

    func callRefreshToken() {
        let params: [String: Any] = [APIParams.Authentication.refreshToken: userManager.refreshToken]
        APIManager(interceptor: APIManagerInterceptor()).call(type: .refreshToken, params: params) { [weak self] (result: Swift.Result<SessionModel, CustomError>) in
            guard let uSelf = self else {
                return
            }
            switch result {
            case .success:
                // TODO: save token.
                uSelf.isSuccess.value = true
            case .failure(let error):
                print(error.body)
                uSelf.isSuccess.value = false
            }
        }
    }
    
}
