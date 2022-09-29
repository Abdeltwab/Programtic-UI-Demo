//
//  ViewController.swift
//  CodeingTask
//
//  Created by Abdeltawab Mohamed on 03/01/2022.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

class ViewController: UIViewController {
    // topView
    private let scrollView = UIScrollView()
    private let headerView = UIView()
    private let topView = UIView()

    // middleView

    private lazy var plansCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let middleView = UIView()
    private let middleViewScrollView = UIScrollView()
    private let middleViewStackView = UIStackView()
    private let middleViewPageControl = UIPageControl()
    private let middleViewStack = UIStackView()
    private var offersViews: [UIView] = []

    // bottomView

    private let bottomView = UIView()
    private let bottomViewButton = UIButton()
    private let bottomViewFirstLine = UILabel()
    private let bottomViewSecondLine = UILabel()

    // propertises
    private var viewModel: ViewModelProtocol?
    private var disposeBag = DisposeBag()

    init(viewModel: ViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        middleViewScrollView.delegate = self
        setupUI()
        setupBinding()
    }
}

private extension ViewController {
    func setupUI() {
        configureSubViews()
    }

    func configureSubViews() {
        configureScrollView()
        configureTopView()
        configureMiddleView()
        configureBottomView()
    }

    func configureScrollView() {
        scrollView.backgroundColor = .white
        scrollView.contentInsetAdjustmentBehavior = .never
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configureTopView() {
        scrollView.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.height.equalTo(view.bounds.height * 0.58)
            make.width.equalToSuperview()
//            make.topMargin.equalTo(scrollView.snp.topMargin).offset(-100) //change later
            make.top.equalTo(view.safeAreaInsets.top)
        }

        configureTopViewPageControl()
    }

    func configureTopViewPageControl() {
        middleViewScrollView.showsHorizontalScrollIndicator = false
        middleViewScrollView.isPagingEnabled = true
        topView.addSubview(middleViewScrollView)

        middleViewScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        middleViewStackView.distribution = .equalSpacing
        middleViewStackView.spacing = 1
        middleViewScrollView.addSubview(middleViewStackView)
        middleViewStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        topView.addSubview(middleViewPageControl)
        middleViewPageControl.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview()
        }

        guard let viewModel = viewModel else { return }
        middleViewPageControl.numberOfPages = viewModel.topViewModels.value.count
        middleViewPageControl.currentPage = 0
        topView.bringSubviewToFront(middleViewPageControl)
    }

    func configureMiddleView(){
        scrollView.addSubview(middleView)
        middleView.snp.makeConstraints { make in
            make.height.equalTo(view.frame.height * 0.19)
            make.width.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
        }
        configurePlansCollecionView()
        let borderView = UIView()
        borderView.backgroundColor = .black
        middleView.addSubview(borderView)
        borderView.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func configurePlansCollecionView(){
        let layout  = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width / 3 , height: view.frame.height * 0.19)
        layout.minimumLineSpacing = 0.4

        layout.scrollDirection = .horizontal
        plansCollectionView = UICollectionView(frame: middleView.frame, collectionViewLayout: layout)
        plansCollectionView.register(SubscriptionPlanCell.self, forCellWithReuseIdentifier: String(describing: SubscriptionPlanCell.self))
        plansCollectionView.showsHorizontalScrollIndicator = false
        middleView.addSubview(plansCollectionView)
        plansCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configureBottomView() {
        scrollView.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.height.equalTo(view.bounds.height * 0.3)
            make.width.equalToSuperview()
            make.top.equalTo(middleView.snp.bottom)
            make.bottom.equalTo(scrollView.snp.bottom)
        }

        // button

        bottomViewButton.titleLabel?.font = .systemFont(ofSize: 24)
        bottomViewButton.setTitle("ACTIVATE     > ", for: [])
        bottomViewButton.backgroundColor = .blue
        bottomViewButton.layer.cornerRadius = 37
        bottomView.addSubview(bottomViewButton)
        bottomView.addSubview(bottomViewFirstLine)
        bottomView.addSubview(bottomViewSecondLine)

        bottomViewButton.backgroundColor = .color(for: .rightSkyColor)
        bottomViewButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(bottomView.snp.width).multipliedBy(0.7)
            make.height.equalTo(bottomView.snp.width).multipliedBy(0.16)
            make.top.equalTo(bottomView.snp.top).offset(view.frame.width * 0.09)
        }

        // first title
        bottomViewFirstLine.text = "Terms of use | Privacy Policy"
        bottomViewFirstLine.textColor = .gray
        bottomViewFirstLine.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bottomViewButton.snp.bottom).offset(10)
        }

        // second line
        bottomViewSecondLine.text = " Restore"
        bottomViewSecondLine.textColor = .gray

        bottomViewSecondLine.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bottomViewFirstLine.snp.bottom).offset(10)
        }
    }
}

private extension ViewController {
    func setupBinding() {
        bindTopViewModels()
        bindMiddelViewModels()
        bindActivateButtonTap()
    }

    func bindTopViewModels() {
        guard let viewModel = self.viewModel else { return }
        viewModel.topViewModels.bind { [weak self] models in
            guard let self = self else { return }
            models.forEach { model in
                let view = SlideView(frame: self.topView.frame)
                view.configureWithModel(model: model)
                self.middleViewStackView.addArrangedSubview(view)
                view.snp.makeConstraints { make in
                    make.height.equalTo(self.topView.snp.height)
                    make.width.equalTo(self.topView.snp.width)
                }
            }
        }.disposed(by: disposeBag)
    }

    func bindMiddelViewModels() {
        // TODO: With CollecionView this can be better and easyier
        // This a demo and use case for stackView
        guard let viewModel = self.viewModel else { return }
        viewModel
            .middleViewModles
            .bind(to: plansCollectionView.rx.items(cellIdentifier: "\(SubscriptionPlanCell.self)")) {
                cellIndex, model, cell in
                guard let cell = cell as? SubscriptionPlanCell else {return}
                cell.setupCellData(with: model)
            }.disposed(by: disposeBag)
    }

    func bindActivateButtonTap() {
        guard let viewModel = viewModel else { return }
        bottomViewButton.rx.tap.bind(to: viewModel.didTapActivateButton).disposed(by: disposeBag)
        // This will print a statment just for Demo
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let pageFraction = scrollView.contentOffset.x / pageWidth
        middleViewPageControl.currentPage = Int(round(pageFraction))
    }
}
