//
//  InternetManagerProtocol.swift
//  POMacArch
//
//  Created by mohamed gamal on 07/12/2021.
//

import Foundation

public protocol InternetManagerProtocol: AnyObject {
    func  isInternetConnectionAvailable () -> Bool
}
