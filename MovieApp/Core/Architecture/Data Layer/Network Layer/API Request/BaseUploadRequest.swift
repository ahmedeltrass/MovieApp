//
//  File.swift
//  
//
//  Created by POMAC on 17/01/2023.
//
import Foundation

open class BaseUploadRequest: APIRequestProtocol {
    public var isUpload: Bool
    public var scheme: String?
    public var isDownload: Bool?
    public var queryParamss: [String: Any]?
    public var baseDomain: String
    public var portNumber: Int?
    public  var path: String
    public  var authorization: APIAuthorization
    public var method: HTTPMethod
    public var queryBody: Any?
    public  var headers: [String: String]
    public  var filesToUplaods: [Media] = []
    public   let boundary = UUID().uuidString
    public   var queryItems: [URLQueryItem]? {
        return queryParams()?.map({ URLQueryItem.init(name: $0.key, value: $0.value)})
    }
    public var url: URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = self.scheme
        urlComponents.path = "\(self.path)"
        urlComponents.host = self.baseDomain
        urlComponents.queryItems = self.queryItems
        return urlComponents.url!
    }
    public var requestURL: URLRequest {
        let timeoutInterval = 20.0
        var request = URLRequest(url: self.url,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: timeoutInterval)
        switch authorization {
        case .bearerToken:
            print(authorization.authData)
            guard let header = authorization.authData as? [String: String] else {
                fatalError("bearerToken header must be as [String:String] ")
            }
            headers.merge(header) { (_, new) in new }
        case .none:
            break
        }
        let mediaFile = filesToUplaods
        request.allHTTPHeaderFields = headers
        request.httpMethod = self.method.rawValue
        if let queryBody = self.queryBody as? [String: String] {
            if !mediaFile.isEmpty {
                let dataBody = createDataBody(withParameters: queryBody, media: mediaFile, boundary: boundary)
                request.httpBody = dataBody
                print(dataBody)
            } else {
                let dataBody = createDataBody(withParameters: queryBody, media: nil, boundary: boundary)
                request.httpBody = dataBody
                print(dataBody)
            }
        } else {
            let dataBody = createDataBody(withParameters: nil, media: mediaFile, boundary: boundary)
            request.httpBody = dataBody
        }
        return request
    }
    public init(filesToUplaods: [Media]) {
        self.filesToUplaods = filesToUplaods
        //        portNumber = 0
        scheme = "https"
        baseDomain = APIUrls.baseDomain
        authorization = .none
        headers = ["Content-Type": "multipart/form-data; boundary=\(boundary)", "Accept": "application/json",
                   "Accept-Language": Locale.preferredLanguages[0]]
        path = ""
        method = .post
        isUpload = true
    }
    public func queryParams() -> [String: String]? {
        return nil
    }
    public  var description: String {
        "RequestURL : \(requestURL.url?.absoluteString ?? "")"
    }
    func createDataBody(withParameters params: [String: String]?, media: [Media]?, boundary: String) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        }
        if let media = media, !media.isEmpty {
            for (index, photo) in media.enumerated() {
                if photo.data != nil {
                    body.append("--\(boundary + lineBreak)")
                    body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.fileName)\"\(lineBreak)")
                    body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                    if let data = photo.data {
                        body.append(data)
                    }
                    body.append(lineBreak)
                }
            }
        }
        body.append("--\(boundary)--\(lineBreak)")
        print(body)
        return body
    }
}

extension Data {
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}

public enum TypeOfData: String {
    case file
    case image
    case excelFile
    case moneyTransferFiles
}

public struct Media {
    let key: String
    let fileName: String
    let data: Data?
    let mimeType: String
}
