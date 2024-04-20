//
//  APICaller.swift
//  UniversitiesApp
//
//  Created by Şehriban Yıldırım on 12.04.2024.
//

import Alamofire

class APICaller{
    
    public static var shared: APICaller = APICaller()
    
    private init(){}
    
    public func getProvince(page:Int, completion: @escaping(Result<Datas, Error>)->Void){
        let url = NetworkConstants.shared.baseURL + "page-\(page).json"
        AF.request(url).responseDecodable(of: Datas.self) { response in
            switch response.result {
            case .success(let items):
                completion(.success(items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
