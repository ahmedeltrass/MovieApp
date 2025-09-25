//
//  HomeUseCase.swift
//  MoviesApp
//
//  Created by Ahmed on 24/09/2025.
//

import Foundation
import Combine
class HomeUseCase: BaseUseCase {
    var category: MovieCategory
    var page: Int
    init(category: MovieCategory,page:Int) {
        self.category = category
        self.page = page
        super.init()
    }
    override func process<T: Codable>(_ outputType: T.Type) -> Future<T, Error> {
        return perfrom(outputType)
    }
    
    private func perfrom<T: Codable>(_ outputType: T.Type) -> Future<T, Error> {
        let request = HomeRequest(category: category,page: page)
        return perform(apiRequest: request)
    }
}
