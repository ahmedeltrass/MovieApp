//
//  NetworkContainer.swift
//  POMacArch
//
//  Created by mohamed gamal on 07/12/2021.
//

import Foundation
public enum Singletons {
   public static let internetManager = InternetConnectionManager()
    public static let apiRequestProvider = APIRequestProvider(internetManager: internetManager)
    public static let apiIManager = APIManager()
}
