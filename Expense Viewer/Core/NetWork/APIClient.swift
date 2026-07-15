

import Foundation

protocol APIClientProtocol {
    func request(from endpoint: Endpoint) async throws -> Data
}

final class APIClient: APIClientProtocol {
    
    private let requestBuilder: URLRequestBuilder
    
    init(requestBuilder: URLRequestBuilder = DefaultURLRequestBuilder()) {
        self.requestBuilder = requestBuilder
    }
    
    func request(from endpoint: Endpoint) async throws -> Data {
        
        guard NetworkReachability.shared.isConnected else {
            throw APIError.networkError
        }
        
        let request = try requestBuilder.build(from: endpoint)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.serverError(statusCode: httpResponse.statusCode)
            }
            
            return data
            
        } catch {
            throw APIError.networkError
        }
    }
}
