import UIKit
import SnapKit

final class ConfirmController: UIViewController {
    
    //MARK: - Properties
    var coordinator: ConfirmCoordinator?
    var viewModel: ConfirmViewModelProtocol?
    
    //MARK: - View
    private lazy var firstView: PaymentView = {
        let view = PaymentView()
        view.titleLabel.text = "Тек.счет"
        view.subtitleLabel.text = "Накопленные бонусы"
        view.priceLabel.text = "\(profileInfo.amount)"
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ic_tran")
        return view
    }()
    
    private lazy var secondView: PaymentView = {
        let view = PaymentView()
        return view
    }()
    
    private lazy var firstConfirmView: ConfirmView = {
        let view = ConfirmView()
        view.titleLabel.text = "Cумма перевода"
        return view
    }()
    
    private lazy var secondConfirmView: ConfirmView = {
        let view = ConfirmView()
        view.titleLabel.text = "Комиссия"
        view.priceLabel.text = "0"
        return view
    }()
    
    private lazy var thirdConfirmView: ConfirmView = {
        let view = ConfirmView()
        view.titleLabel.text = "Cумма списания"
        return view
    }()
        
    private lazy var fixedButton: UIButton = {
        let button = UIButton()
        button.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        button.layer.cornerRadius = 12
        button.setTitle("Подтвердить", for: .normal)
        button.setTitleColor(.enBlue, for: .normal)
        button.backgroundColor = .enBlue
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setup()
    }
    
    //MARK: - Methdos
    @objc
    private func buttonDidTap() {
        viewModel?.payRetake()
    }
    
    private func setup() {
        setupViews()
        makeConstraints()
        configure()
    }
    
    private func setupViews() {
        [firstView, secondView, iconImageView, fixedButton, firstConfirmView, secondConfirmView, thirdConfirmView].forEach {
            view.addSubview($0)
        }
    }

    private func makeConstraints() {
        firstView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(66)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(firstView.snp.bottom).inset(8)
            make.centerX.equalToSuperview()
        }
        
        secondView.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).inset(4)
            make.leading.trailing.equalToSuperview().inset(14)
            make.height.equalTo(66)
        }
        
        firstConfirmView.snp.makeConstraints { make in
            make.top.equalTo(secondView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(66)
        }
        
        secondConfirmView.snp.makeConstraints { make in
            make.top.equalTo(firstConfirmView.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(66)
        }
        
        thirdConfirmView.snp.makeConstraints { make in
            make.top.equalTo(secondConfirmView.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(66)
        }
        
        fixedButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(24)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(46)
            make.width.equalTo(327)
        }
    }
    
    private func configure() {
        guard let viewModel = viewModel else {return}
        
        firstConfirmView.priceLabel.text = "\(viewModel.retake.paymentAmount)"
        thirdConfirmView.priceLabel.text = "\(viewModel.retake.paymentAmount)"
        secondView.titleLabel.text = viewModel.retake.title
        secondView.subtitleLabel.text = "до 11 апреля"
        secondView.priceLabel.text = "\(viewModel.retake.paymentAmount)"
    }
}
