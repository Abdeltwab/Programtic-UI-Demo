//
//  SlideView.swift
//  CodeingTask
//
//  Created by Abdeltawab Mohamed on 04/01/2022.
//
import UIKit
import SnapKit

class SlideView: UIView {

    var imageView =  UIImageView()
    var titleLabel = UILabel()
    var subTitleLabel = UILabel()
    var descriptionLabel = UILabel()
    let screenWidth = UIScreen.main.bounds.size.height


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        self.addSubview(descriptionLabel)

        titleLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 25)
        titleLabel.textColor = .white
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(80)
            make.centerX.equalTo(imageView.snp.centerX)
        }
        subTitleLabel.textColor = .white
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottomMargin).inset(-12)
            make.centerX.equalTo(titleLabel.snp.centerX)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).multipliedBy(0.3)
            make.height.equalTo(imageView.snp.width)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        descriptionLabel.font = UIFont(name:"HelveticaNeue-light", size: 14)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 2
        descriptionLabel.snp.makeConstraints { make in
            //TODO : Fix this , make it dynamic
            make.bottom.equalTo(self.snp.bottom).inset(80)
            make.centerX.equalTo(imageView.snp.centerX)
        }

        imageView.backgroundColor = .clear
        imageView.layoutIfNeeded()
        imageView.layer.cornerRadius = imageView.bounds.height / 2

    }


    func configureWithModel(model:TopViewModel){
        imageView.image = model.image
        titleLabel.text = model.title
        subTitleLabel.text = model.subTitle
        descriptionLabel.text = model.description
        self.backgroundColor = model.color
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
