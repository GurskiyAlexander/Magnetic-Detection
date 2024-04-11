import UIKit

// MARK: - CustomNavBarType

enum CustomNavBarType {
    case standart
    case backWithTitle
    case righButton
}

// MARK: - CustomNavBar

final class CustomNavBar: UIView {
    var backAction: (() -> Void)?
    var rightAction: (() -> Void)?

    private lazy var leftStack = UIStackView().then {
        $0.spacing = 8
    }

    private lazy var leftImageView = UIImageView().then {
        $0.image = .back
        $0.contentMode = .scaleAspectFill
    }

    private lazy var leftTitleLabel = UILabel().then {
        $0.textColor = .c6D59D3
        $0.font = .systemFont(ofSize: 17, weight: .regular)
    }

    private lazy var rightImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = .settings
        $0.isUserInteractionEnabled = true
    }

    private lazy var centerTitleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 17, weight: .semibold)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(
        type: CustomNavBarType = .standart,
        previusName: String = "",
        name: String = ""
    ) {
        switch type {
            case .standart:
                rightImageView.isHidden = true
                leftTitleLabel.isHidden = true
            case .backWithTitle:
                rightImageView.isHidden = true
            case .righButton:
                leftStack.isHidden = true
                centerTitleLabel.isHidden = true
        }
        
        centerTitleLabel.text = name
        leftTitleLabel.text = previusName
    }

    private func setupUI() {
        let leftGesture = UITapGestureRecognizer(target: self, action: #selector(didTapedBack))
        let rightGesture = UITapGestureRecognizer(target: self, action: #selector(didTapedRight))
        leftStack.addGestureRecognizer(leftGesture)
        rightImageView.addGestureRecognizer(rightGesture)
        leftStack.addArrangedSubviews(leftImageView, leftTitleLabel)
        add(subviews: leftStack, rightImageView, centerTitleLabel)
    }
    private func setupConstraints() {
        leftStack.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }

        centerTitleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        rightImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }

        snp.makeConstraints {
            $0.height.equalTo(42)
        }
    }

    @objc
    private func didTapedBack() {
        leftStack.animateClick { [weak self] in
            self?.backAction?()
        }
    }

    @objc
    private func didTapedRight() {
        rightImageView.animateClick { [weak self] in
            self?.rightAction?()
        }
    }
}
