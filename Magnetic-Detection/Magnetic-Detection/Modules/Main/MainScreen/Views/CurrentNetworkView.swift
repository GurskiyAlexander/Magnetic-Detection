import UIKit

// MARK: - CurrentNetworkView

final class CurrentNetworkView: UIView {
    var action: (() -> Void)?

    private let mainStack = UIStackView().then {
        $0.spacing = 8
        $0.axis = .vertical
    }

    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.text = "Current Wi-Fi"
    }

    private lazy var nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 28, weight: .bold)
        $0.textColor = .c6D59D3
        $0.textAlignment = .center
        $0.layer.shadowOffset = .zero
        $0.layer.shadowRadius = 6
        $0.layer.shadowOpacity = 0.8
        $0.layer.shadowColor = UIColor.c6D59D3.cgColor
    }

    private lazy var subTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17, weight: .regular)
        $0.textColor = .c525878
        $0.textAlignment = .center
        $0.text = "Ready to Scan this network"
    }

    private lazy var mainButton = UIButton().then {
        $0.setTitle("Scan current network", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.backgroundColor = .c6D59D3
        $0.layer.cornerRadius = 25
        $0.addTarget(self, action: #selector(didTouchButton), for: .touchUpInside)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        setupConstraints()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(mainStack)
        backgroundColor = .c100D2C
        layer.cornerRadius = 8
        mainStack.addArrangedSubviews(titleLabel, nameLabel, subTitleLabel, mainButton)
        mainStack.setCustomSpacing(16, after: nameLabel)
    }

    private func setupConstraints() {
        mainStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(24)
        }

        mainButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }

    @objc
    private func didTouchButton() {
        mainButton.animateClick { [weak self] in
            self?.action?()
        }
    }
}

// MARK: - ConfigurableView

extension CurrentNetworkView {
    func configure(with name: String) {
        nameLabel.text = name
    }
}
