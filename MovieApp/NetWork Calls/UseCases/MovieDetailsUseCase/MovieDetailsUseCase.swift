//
//  MovieDetailsUseCase.swift
//  MovieApp
//
//  Created by Ahmed Eltrass on 24/09/2025.
//

import Foundation
import Combine
class MovieDetailsUseCase: BaseUseCase {
    var id: Int
    init(id:Int) {
        self.id = id
        super.init()
    }
    override func process<T: Codable>(_ outputType: T.Type) -> Future<T, Error> {
        return perfrom(outputType)
    }
    
    private func perfrom<T: Codable>(_ outputType: T.Type) -> Future<T, Error> {
        let request = MovieDetailsRequest(id: id)
        return perform(apiRequest: request)
    }
}
