//
//  APIRequestProvider.swift
//  POMacArch
//
//  Created by mohamed gamal on 07/12/2021.
//

import Foundation
import Combine
import SwiftUI
public class APIRequestProvider: NSObject, APIRequestProviderProtocol {
    @EnvironmentObject var mainRouter: Router<MainRoute>
    public var progress: PassthroughSubject<Float, Never> = .init()
    let internetManager: InternetManagerProtocol
    init(internetManager: InternetManagerProtocol) {
        self.internetManager = internetManager
    }
    public func perform(apiRequest: APIRequestProtocol, completion: @escaping APIRequestCompletion) {
        guard internetManager.isInternetConnectionAvailable() else {
            completion(Swift.Result<Data, APIRequestProviderError>.failure(.noInternet(message: "NoInternetError")))
            return
        }
        guard Singletons.internetManager.isInternetConnectionAvailable()  else {
            completion(Swift.Result<Data, APIRequestProviderError>.failure(.noInternet(message: "NoInternetError")))
            return
        }
        performRequest(apiRequest.requestURL, completion: completion)
    }

    private func performRequest( _ request: URLRequest, completion: @escaping APIRequestCompletion) {

        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)

        let dataTask = urlSession.dataTask(with: request) { [weak self]data, response, error in
            if let error = error {
                let failure = APIRequestProviderError.requestFailed(error: error)
                completion(Result<Data, APIRequestProviderError>.failure(failure))
                return
            }

            if let response = response as? HTTPURLResponse {
                let statusCode = response.statusCode
                switch statusCode {
                case 200...299:
                    let data = data ?? Data.init()
                    completion(Result<Data, APIRequestProviderError>.success(data))
                default:
                    let failure = APIRequestProviderError.server(statusCode: statusCode, data: data)
                    completion(Result<Data, APIRequestProviderError>.failure(failure))
                }
            }
        }
        dataTask.resume()
    }

}

extension APIRequestProvider: URLSessionTaskDelegate {

    public func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        let uploadProgress = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
        progress.send(uploadProgress)
    }
}
