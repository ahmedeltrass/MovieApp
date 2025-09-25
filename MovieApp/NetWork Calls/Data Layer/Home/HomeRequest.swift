//
//  HomeRequest.swift
//  MoviesApp
//
//  Created by Ahmed_POMAC on 24/09/2025.
//

class HomeRequest: BaseAPIRequest {
    private let page: Int
    init(category: MovieCategory, page: Int) {
        self.page = page
        super.init()
        path = APIUrls.getAllMovies + "\(category.rawValue)"
        method = .get
    }
    override func queryParams() -> [String : String]? {
        [
            "api_key": "dd63de6b85594f5e3bef0de16c32ead8", // TMDb API Key
            "language": "en-US",
            "page": "\(page)"
        ]
    }
}
