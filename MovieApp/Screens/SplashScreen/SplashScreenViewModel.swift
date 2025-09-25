//
//  SplashScreenViewModel.swift
//  Hagazt
//
//  Created by POMAC on 21/02/2024.
//

import Foundation
import Combine
class SplashScreenViewModel: ObservableObject {
    //MARK: - request properties
    @Published var loaging: Bool = false
    @Published var error: String = ""
    @Published var hasError: Bool = false
    @Published var isActive: Bool = false
}
