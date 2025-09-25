//
//  NetworkManagerProtocol.swift
//  POMacArch
//
//  Created by Mohamed gamal on 05/05/2021.
//  Copyright © 2021 POMac. All rights reserved.
//

import Foundation
import Combine

 public protocol NetworkManagerProtocol: AnyObject {
    func perform<T: Codable>(apiRequest: APIRequestProtocol,
                             provider: APIRequestProviderProtocol,
                             outputType: T.Type) -> Future<T, Error>
}
