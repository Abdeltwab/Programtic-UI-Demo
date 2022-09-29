//
//  CustomButtonView.swift
//  CodeingTask
//
//  Created by Abdeltawab Mohamed on 04/01/2022.
//

import UIKit

// MARK: - Not Used 
class CustomButtonView: UIView {

    private let mostPopularView = UIView()
    private let mainLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let priceLabel = UILabel()
    private let mostPopluareLabel = UILabel()
    private let stackView = UIStackView()
    private let buttonView = UIButton()
    private var isBorderDisplayed =  false
    private static var viewCollecion = [UIView]() // just a work around , can be done more easy by collecion view

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(buttonView)
        self.addSubview(mostPopularView)
        self.addSubview(stackView)
        
        buttonView.addTarget(self, action:#selector(viewTapped), for: .touchUpInside)
        buttonView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mostPopularView.isHidden = true
        mostPopularView.layer.cornerRadius = 8
        mostPopularView.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).multipliedBy(0.85)
            make.height.equalTo(self.snp.width).multipliedBy(0.15)
            make.top.equalTo(self.snp.top).offset(-(self.frame.height * 0.5))
            make.centerX.equalToSuperview()
        }
        
        mostPopluareLabel.font = .systemFont(ofSize: 10)
        mostPopularView.addSubview(mostPopluareLabel)
        mostPopluareLabel.text = "Most Popular"
        mostPopluareLabel.textColor = .white

        mostPopluareLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        mostPopularView.bringSubviewToFront(mostPopluareLabel)
                
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 5

        stackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.left.right.equalToSuperview()
        }

        stackView.addArrangedSubview(mainLabel)
        stackView.addArrangedSubview(subTitleLabel)
        stackView.addArrangedSubview(priceLabel)

        
        mainLabel.font = .systemFont(ofSize: 30)
        subTitleLabel.font = .systemFont(ofSize: 15)
        priceLabel.font = .systemFont(ofSize: 20)

        CustomButtonView.viewCollecion.append(self)
        self.bringSubviewToFront(buttonView)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMostPopularView(){
        mostPopularView.isHidden = false
        mostPopularView.backgroundColor = UIColor.color(for: .rightSkyColor)
        configureBorderView(enabled: true)
        bringSubviewToFront(mostPopularView)
    }

    func configureBorderView(enabled:Bool){
        self.layer.borderWidth = enabled ? 7 : 0
        self.layer.borderColor = enabled ? UIColor.color(for: .rightSkyColor).cgColor  : UIColor.clear.cgColor
    }
    
    func removeMostPopularView(){
        mostPopularView.isHidden = true
    }
    
    func configureWithModel(model: MiddleViewModel ){
        mainLabel.text = model.period
        subTitleLabel.text = model.dateType
        priceLabel.text = model.price
        model.isPopular ? setupMostPopularView() : removeMostPopularView()
    }
    
    func configureSelectedViewColor(color:UIColor = .black){
        self.mainLabel.textColor  = color
        self.priceLabel.textColor  = color
        self.subTitleLabel.textColor  = color
    }
    
    @objc func viewTapped(){
        // TODO : this logic can be done very easily by collecionView , or CompostiaonlLyout
        //just done this due to time limit
        
        for view  in CustomButtonView.viewCollecion {
            let v = view as! CustomButtonView
            v.configureBorderView(enabled: false)
            v.configureSelectedViewColor()
        }
        
        if isBorderDisplayed {
            configureBorderView(enabled: false)
            configureSelectedViewColor()
        }else {
            configureBorderView(enabled: true)
            configureSelectedViewColor(color: .color(for: .rightSkyColor))
        }
       

    }
    
}

