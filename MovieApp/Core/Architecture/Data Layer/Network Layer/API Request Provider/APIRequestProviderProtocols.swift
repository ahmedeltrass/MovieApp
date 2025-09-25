//
//  APIRequestProviderProtocols.swift
//  POMacArch
//
//  Created by mohamed gamal on 07/12/2021.
//

import Foundation
import Combine
public protocol APIRequestProviderProtocol {
    var progress: PassthroughSubject<Float, Never> {get set}
    typealias APIRequestCompletion = (_ result: Result<Data, APIRequestProviderError>) -> Void
    func perform(apiRequest: APIRequestProtocol, completion: @escaping APIRequestCompletion)
}
