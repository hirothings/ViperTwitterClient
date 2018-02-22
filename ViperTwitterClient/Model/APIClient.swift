//
//  APIClient.swift
//  ViperTwitterClient
//
//  Created by hirothings on 2017/06/11.
//  Copyright © 2017年 hirothings. All rights reserved.
//

import Foundation
import TwitterKit
import RxSwift

public class APIClient {
    private let userID: String
    private let store = TWTRTwitter.sharedInstance().sessionStore
    
    public init() {
        userID = store.session()?.userID ?? ""
    }
    
    public func call<Request: TwitterRequest>(request: Request) -> Observable<Request.Response> {
        let client = TWTRAPIClient(userID: userID)
        var clientError: NSError?
        let twRequest = client.urlRequest(withMethod: "GET",
                                          urlString: request.urlString,
                                          parameters: request.parameters,
                                          error: &clientError)
        
        return Observable.create({ (observer: AnyObserver<Request.Response>) -> Disposable in
            let task: Progress = client.sendTwitterRequest(twRequest) { (response, data, error) in
                guard let data = data else {
                    if let error = error {
                        let nsError = error as NSError
                        observer.onError(TwitterAPIError(error: nsError))
                    } else {
                        observer.onError(TwitterAPIError.undefindError)
                    }
                    return
                }
                if let error = error {
                    let nsError = error as NSError
                    observer.onError(TwitterAPIError(error: nsError))
                    return
                }
                do {
                    let res = try request.response(data: data)
                    observer.on(.next(res))
                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
            }
            return Disposables.create {
                task.cancel()
            }
        })
    }
}
