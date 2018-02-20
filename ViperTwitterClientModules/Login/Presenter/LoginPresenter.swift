//
//  LoginPresenter.swift
//  ViperTwitterClientModules
//
//  Created by hirothings on 2018/02/12.
//  Copyright © 2018年 hirothings. All rights reserved.
//

import Foundation

protocol LoginPresentation: class {
    func succeedLogin(userID: String)
    init(
        view: LoginView?,
        router: LoginWireframe
    )
}

class LoginPresenter: LoginPresentation, ErrorHandler {
    private let view: LoginView?
    private let router: LoginWireframe
    
    required init(view: LoginView?, router: LoginWireframe) {
        self.view = view
        self.router = router
    }
    
    func succeedLogin(userID: String) {
        router.showTimelineView(userID: userID)
    }
}
