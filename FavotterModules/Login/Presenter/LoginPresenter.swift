//
//  LoginPresenter.swift
//  FavotterModules
//
//  Created by hirothings on 2018/02/12.
//  Copyright © 2018年 hirothings. All rights reserved.
//

import Foundation

protocol LoginPresentation: class {
    func succeedLogin(userID: String)
    func failedLogin(with error: Error)
    init(
        view: LoginView?,
        router: LoginWireframe
    )
}

class LoginPresenter: LoginPresentation {
    private let view: LoginView?
    private let router: LoginWireframe
    
    required init(view: LoginView?, router: LoginWireframe) {
        self.view = view
        self.router = router
    }
    
    func succeedLogin(userID: String) {
        router.showTimelineView(userID: userID)
    }
    
    func failedLogin(with error: Error) {
        // TODO: エラー処理
        view?.showError(message: error.localizedDescription)
    }
}
