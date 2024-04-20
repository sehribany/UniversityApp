//
//  NetworkConstants.swift
//  UniversitiesApp
//
//  Created by Şehriban Yıldırım on 12.04.2024.
//

import Foundation

class NetworkConstants{
    public static var shared: NetworkConstants = NetworkConstants()
    
    private init(){}
    
    public var baseURL:String{
        get{
            return "https://storage.googleapis.com/invio-com/usg-challenge/universities-at-turkey/"
        }
    }
}
