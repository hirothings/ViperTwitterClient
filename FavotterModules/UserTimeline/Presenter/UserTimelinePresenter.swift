//
//  UserTimelinePresenter.swift
//  Favotter
//
//  Created by hirothings on 2018/1/2.
//  Copyright © 2018 hirothings. All rights reserved.
//

import Foundation

protocol UserTimelinePresentation {
    init(
        view: UserTimelineView,
        router: UserTimelineWireframe,
        interactor: UserTimelineUsecase
    )
    
    func viewDidLoad()
}

class UserTimelinePresenter: UserTimelinePresentation {
    private weak var view: UserTimelineView?
    private let router: UserTimelineWireframe
    private let interactor: UserTimelineUsecase
    
    required init(
        view: UserTimelineView,
        router: UserTimelineWireframe,
        interactor: UserTimelineUsecase
        ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        
    }
}

extension UserTimelinePresenter: UserTimelineInteractorOutput {

}
