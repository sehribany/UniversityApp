//
//  SplashViewModel.swift
//  UniversitiesApp
//
//  Created by Şehriban Yıldırım on 13.04.2024.
//

import Foundation

protocol SplashViewDataSource{}

protocol SplashViewEventSource{
    var didSuccessFetchProvince: VoidClosure? { get set }
}

protocol SplashViewProtocol: SplashViewDataSource, SplashViewEventSource{}

final class SplashViewModel: SplashViewProtocol{
    var page = 1
    var isPagingEnabled  = false
    var isRequestEnabled = false
    var didSuccessFetchProvince: VoidClosure?
    var didFailFetchProvince: ErrorClosure?
}

extension SplashViewModel{
    func fetchData(){
        self.isRequestEnabled = false
        APICaller.shared.getProvince(page: page) { results in
            self.isRequestEnabled = true
            switch results{
            case .success(let response):
                print(response)
                //let items = response.data.map({TableCellViewModel(province: $0)})
                //self.cellItems.append(contentsOf: items)
                self.page += 1
                self.isPagingEnabled =  response.currentPage <=  response.totalPage
                self.didSuccessFetchProvince?()
            case .failure(let error):
                self.didFailFetchProvince?(error)
            }
        }
    }
}
