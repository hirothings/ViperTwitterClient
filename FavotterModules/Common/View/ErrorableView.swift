//
//  ErrorView.swift
//  FavotterModules
//
//  Created by hirothings on 2018/02/12.
//  Copyright © 2018年 hirothings. All rights reserved.
//

import Foundation

protocol ErroableView: class {
    func showError(message: String)
}

extension ErrorView where Self: UIViewController {
    func showError(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
