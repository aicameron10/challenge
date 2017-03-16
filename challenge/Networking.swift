import UIKit
import DATAStack
import Sync
import Alamofire

class Networking: NSObject {
    
    let dataStack: DATAStack
    
    required init(dataStack: DATAStack) {
        self.dataStack = dataStack
    }
    
    public func fetchUsers(_ completion: @escaping (NSError?) -> Void)  {
        
        let urlString: String
        
        urlString = Constants.Users
        
        Networking.Manager.request(urlString, method: .get).responseJSON { response in
            
            if let jsonResponse = response.result.value {
                
                let responseJ = jsonResponse
                
                
                let json = JSON(responseJ as Any)
                
                let k = "{\"data\":" + json.rawString()! + "}"
                
                let dict = self.convertToDictionary(text: k)
                
                //print(dict?["data"] as! [[String : Any]])
                
                Sync.changes(dict?["data"] as! [[String : Any]], inEntityNamed: "User", dataStack: self.dataStack) { error in
                    completion(error)
                }
                
                
            }
            
            if let error = response.result.error  as? AFError {
                switch error {
                case .invalidURL(let url):
                    print("Invalid URL: \(url) - \(error.localizedDescription)")
                case .parameterEncodingFailed(let reason):
                    print("Parameter encoding failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                case .multipartEncodingFailed(let reason):
                    print("Multipart encoding failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                case .responseValidationFailed(let reason):
                    print("Response validation failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                    
                    switch reason {
                    case .dataFileNil, .dataFileReadFailed:
                        print("Downloaded file could not be read")
                    case .missingContentType(let acceptableContentTypes):
                        print("Content Type Missing: \(acceptableContentTypes)")
                    case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                        print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                    case .unacceptableStatusCode(let code):
                        print("Response status code was unacceptable: \(code)")
                    }
                case .responseSerializationFailed(let reason):
                    print("Response serialization failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                }
                
                print("Underlying error: \(error.underlyingError)")
            } else if let error = response.result.error  as? URLError {
                print("URLError occurred: \(error)")
            }
            
        }
    }
    
    public func fetchAlbums(_ completion: @escaping (NSError?) -> Void)  {
        
        let urlString: String
        
        urlString = Constants.Albums
        
        Networking.Manager.request(urlString, method: .get).responseJSON { response in
            
            if let jsonResponse = response.result.value {
                
                let responseJ = jsonResponse
                
                let json = JSON(responseJ as Any)
                
                let k = "{\"data\":" + json.rawString()! + "}"
                
                let dict = self.convertToDictionary(text: k)
                
                //print(dict?["data"] as! [[String : Any]])
                
                Sync.changes(dict?["data"] as! [[String : Any]], inEntityNamed: "Albums", dataStack: self.dataStack) { error in
                    completion(error)
                }
                
                
            }
            
            if let error = response.result.error  as? AFError {
                switch error {
                case .invalidURL(let url):
                    print("Invalid URL: \(url) - \(error.localizedDescription)")
                case .parameterEncodingFailed(let reason):
                    print("Parameter encoding failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                case .multipartEncodingFailed(let reason):
                    print("Multipart encoding failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                case .responseValidationFailed(let reason):
                    print("Response validation failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                    
                    switch reason {
                    case .dataFileNil, .dataFileReadFailed:
                        print("Downloaded file could not be read")
                    case .missingContentType(let acceptableContentTypes):
                        print("Content Type Missing: \(acceptableContentTypes)")
                    case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                        print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                    case .unacceptableStatusCode(let code):
                        print("Response status code was unacceptable: \(code)")
                    }
                case .responseSerializationFailed(let reason):
                    print("Response serialization failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                }
                
                print("Underlying error: \(error.underlyingError)")
            } else if let error = response.result.error  as? URLError {
                print("URLError occurred: \(error)")
            }

            
        }
    }
    
    public func fetchPosts(_ completion: @escaping (NSError?) -> Void)  {
        
        let urlString: String
        
        urlString = Constants.Posts
        
        Networking.Manager.request(urlString, method: .get).responseJSON { response in
            
            if let jsonResponse = response.result.value {
                
                let responseJ = jsonResponse
                
                
                let json = JSON(responseJ as Any)
                
                let k = "{\"data\":" + json.rawString()! + "}"
                
                let dict = self.convertToDictionary(text: k)
                
                //print(dict?["data"] as! [[String : Any]])
                
                Sync.changes(dict?["data"] as! [[String : Any]], inEntityNamed: "Posts", dataStack: self.dataStack) { error in
                    completion(error)
                }
                
                
            }
            if let error = response.result.error  as? AFError {
                switch error {
                case .invalidURL(let url):
                    print("Invalid URL: \(url) - \(error.localizedDescription)")
                case .parameterEncodingFailed(let reason):
                    print("Parameter encoding failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                case .multipartEncodingFailed(let reason):
                    print("Multipart encoding failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                case .responseValidationFailed(let reason):
                    print("Response validation failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                    
                    switch reason {
                    case .dataFileNil, .dataFileReadFailed:
                        print("Downloaded file could not be read")
                    case .missingContentType(let acceptableContentTypes):
                        print("Content Type Missing: \(acceptableContentTypes)")
                    case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                        print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                    case .unacceptableStatusCode(let code):
                        print("Response status code was unacceptable: \(code)")
                    }
                case .responseSerializationFailed(let reason):
                    print("Response serialization failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                }
                
                print("Underlying error: \(error.underlyingError)")
            } else if let error = response.result.error  as? URLError {
                print("URLError occurred: \(error)")
            }

            
            
        }
    }
    
    public func fetchPhotos(_ completion: @escaping (NSError?) -> Void)  {
        
        let urlString: String
        
        urlString = Constants.Photos
        
        Networking.Manager.request(urlString, method: .get).responseJSON { response in
            
            if let jsonResponse = response.result.value {
                
                let responseJ = jsonResponse
                
                
                let json = JSON(responseJ as Any)
                
                let k = "{\"data\":" + json.rawString()! + "}"
                
                let dict = self.convertToDictionary(text: k)
                
                
                Sync.changes(dict?["data"] as! [[String : Any]], inEntityNamed: "Photos", dataStack: self.dataStack) { error in
                    completion(error)
                }
                
                
            }
            if let error = response.result.error  as? AFError {
                switch error {
                case .invalidURL(let url):
                    print("Invalid URL: \(url) - \(error.localizedDescription)")
                case .parameterEncodingFailed(let reason):
                    print("Parameter encoding failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                case .multipartEncodingFailed(let reason):
                    print("Multipart encoding failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                case .responseValidationFailed(let reason):
                    print("Response validation failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                    
                    switch reason {
                    case .dataFileNil, .dataFileReadFailed:
                        print("Downloaded file could not be read")
                    case .missingContentType(let acceptableContentTypes):
                        print("Content Type Missing: \(acceptableContentTypes)")
                    case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                        print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                    case .unacceptableStatusCode(let code):
                        print("Response status code was unacceptable: \(code)")
                    }
                case .responseSerializationFailed(let reason):
                    print("Response serialization failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                }
                
                print("Underlying error: \(error.underlyingError)")
            } else if let error = response.result.error  as? URLError {
                print("URLError occurred: \(error)")
            }

            
            
        }
    }
    
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    private static var Manager: Alamofire.SessionManager = {
        
        // Create the server trust policies
        let serverTrustPolicies: [String: ServerTrustPolicy] = [:]
        
        // Create custom manager
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        
        return manager
    }()
    
}
