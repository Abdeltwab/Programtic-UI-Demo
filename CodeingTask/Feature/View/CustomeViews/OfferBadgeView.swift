//
//  mostPopularView.swift
//  CodeingTask
//
//  Created by Abdeltawab Mohamed on 17/01/2022.
//

import UIKit

class OfferBadgeView: UIView {
    // MARK: - Outlets
//    private let contentView = UIView()

    // MARK: - LifeCylce

    override init(frame: CGRect) {
        super.init(frame: frame)
        configreViews()
        configreLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension OfferBadgeView {
    func configreViews(){
        self.backgroundColor = .red
        self.layer.cornerRadius = 10
    }

    func configreLayout() {
//        contentView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
        
        self.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
    }
}

extension OfferBadgeView {
    func setupCellData(with model: MiddleViewModel) {
    }
}
