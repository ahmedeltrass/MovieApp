//
//  MovieDetailsRequest.swift
//  MovieApp
//
//  Created by Ahmed Eltrass on 24/09/2025.
//

class MovieDetailsRequest: BaseAPIRequest {
    private let id: Int
    init( id: Int) {
        self.id = id
        super.init()
        path = APIUrls.getMovie + "\(id)"
        method = .get
    }
    override func queryParams() -> [String : String]? {
        [
            "api_key": "dd63de6b85594f5e3bef0de16c32ead8",
            "language": "en-US",
        ]
    }
}
