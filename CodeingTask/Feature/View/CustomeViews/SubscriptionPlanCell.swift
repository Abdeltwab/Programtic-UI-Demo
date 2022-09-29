//
//  CollectionViewCell.swift
//  CodeingTask
//
//  Created by Abdeltawab Mohamed on 06/01/2022.
//

import UIKit

class SubscriptionPlanCell: UICollectionViewCell {
    // MARK: - Outlets
    
    private let stackView = UIStackView()
    private let periodLable = UILabel()
    private let periodTypeLable = UILabel()
    private let priceLable = UILabel()
    private let badgeView = OfferBadgeView()
    private let borderView = UIView()
    // MARK: - LifeCylce
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = false
        configreViews()
        configreLayout()
        self.addSubview(badgeView)
        badgeView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(-10)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SubscriptionPlanCell {
    
    // TODO : the badge view https://stackoverflow.com/questions/43003611/superview-border-is-cutting-into-subview/49445261
    
    func configreViews() {
        self.addSubview(periodLable)
        self.addSubview(stackView)
        self.addSubview(borderView)
        stackView.addArrangedSubview(periodTypeLable)
        stackView.addArrangedSubview(priceLable)
        
        periodLable.font = .boldSystemFont(ofSize: 28)
        periodTypeLable.font = .systemFont(ofSize: 13)
        priceLable.font = .boldSystemFont(ofSize: 18)
        
        stackView.spacing = 2
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        borderView.backgroundColor = .clear
        borderView.layer.borderColor = UIColor.blue.cgColor
        borderView.layer.borderWidth = 5
        self.sendSubviewToBack(borderView)

    }
    
    func configreLayout() {
        periodLable.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(contentView.frame.height * 0.25)
            make.centerX.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(periodLable.snp.bottom).inset(-6)
        }
        
        borderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
}

extension SubscriptionPlanCell {
    
    func setupCellData(with model: MiddleViewModel){
        periodLable.text = model.period
        periodTypeLable.text = model.dateType
        priceLable.text = model.price
    }
}
