//
//  ViewModel.swift
//  CodeingTask
//
//  Created by Abdeltawab Mohamed on 03/01/2022.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit


protocol ViewModelProtocol {
    var topViewModels : BehaviorRelay<[TopViewModel]> {get }
    var middleViewModles : BehaviorRelay<[MiddleViewModel]> {get }
    var didTapActivateButton: PublishRelay<Void> {get}

}

struct ViewModel : ViewModelProtocol {
    
    //MARK: - Propertises
    private let disposeBage = DisposeBag()
    var topViewModels =  BehaviorRelay<[TopViewModel]>(value: [])
    var middleViewModles =  BehaviorRelay<[MiddleViewModel]>(value: [])
    var didTapActivateButton =  PublishRelay<Void>()
    
    
    
    init(){
        setuptData()
        setupBinding()
    }
    
}

private extension ViewModel {
    func setuptData(){
        //TODO : This should be from an API
        let topViewModel1 = TopViewModel(title: "Real Number 1", subTitle: "Contact any One with your real number ", description: "3 days free, then $7.99/wk ", image: UIImage(named: "ic_onboarding_1")!, color: .color(for: .topBlueColor))
        let topViewModel2 = TopViewModel(title: "Real Number 2", subTitle: "Contact any One with your real number ", description: "3 days free, then $7.99/wk ", image: UIImage(named: "ic_onboarding_1")!,color: .color(for: .bottomBlueColor))
        let topViewModel3 = TopViewModel(title: "Real Number 3", subTitle: "Contact any One with your real number ", description: "3 days free, then $7.99/wk ", image: UIImage(named: "ic_onboarding_1")!,color: .color(for: .leftSkyColor))
        let topViewModel4 = TopViewModel(title: "Real Number 4", subTitle: "Contact any One with your real number ", description: "3 days free, then $7.99/wk ", image: UIImage(named: "ic_onboarding_1")!,color: .color(for: .rightSkyColor))
        topViewModels.accept([topViewModel1,topViewModel2,topViewModel3,topViewModel4])
        
        
        
        let middleViewModel1 = MiddleViewModel(period: "3", dateType: "months", price: "$29.99", isPopular: false)
        let middleViewModel2 = MiddleViewModel(period: "3-Day", dateType: "trial", price: "$7.99", isPopular: true)
        let middleViewModel3 = MiddleViewModel(period: "12", dateType: "months", price: "$59.99", isPopular: false)

        middleViewModles.accept([middleViewModel1,middleViewModel2,middleViewModel3])
        
       
    }
    
    func setupBinding(){
        didTapActivateButton.subscribe { _ in
            print("Active Button Pressed")
        }.disposed(by: disposeBage)

    }
}

