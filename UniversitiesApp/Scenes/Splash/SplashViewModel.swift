//
//  SplashViewModel.swift
//  UniversitiesApp
//
//  Created by Şehriban Yıldırım on 13.04.2024.
//

import Foundation

protocol SplashViewDataSource{
    func numberOfItemsAt(section:Int) -> Int
    func cellItemAt(indexPath: IndexPath) -> ProvinceCellProtocol
}

protocol SplashViewEventSource{
    var didSuccessFetchProvince: VoidClosure? { get set }
}

protocol SplashViewProtocol: SplashViewDataSource, SplashViewEventSource{}

final class SplashViewModel: SplashViewProtocol{
    
    var cellItems: [ProvinceCellModel] = []
    var page = 1
    var isPagingEnabled  = false
    var isRequestEnabled = false
    var didSuccessFetchProvince: VoidClosure?
    var didFailFetchProvince: ErrorClosure?
    
    func numberOfItemsAt(section: Int) -> Int {
        cellItems.count
    }
    
    func cellItemAt(indexPath: IndexPath) -> ProvinceCellProtocol {
        cellItems[indexPath.row]
    }
}

extension SplashViewModel{
    func fetchData(){
        self.isRequestEnabled = false
        APICaller.shared.getProvince(page: page) { results in
            self.isRequestEnabled = true
            switch results{
            case .success(let response):
                print(response.data[0].province)
                let items = response.data.map({ProvinceCellModel(province: $0)})
                self.cellItems.append(contentsOf: items)
                self.page += 1
                self.isPagingEnabled =  response.currentPage < response.totalPage
                self.didSuccessFetchProvince?()
            case .failure(let error):
                self.didFailFetchProvince?(error)
            }
        }
    }
}
