import UIKit

final class HeaderView: UIView {
    var isFail: Bool {
        get { false }
        set { titleLabel.textColor = newValue ? .cD92929 : .c6D59D3 }
    }

    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }

    var subtitle: String? {
        get { subtitleLabel.text }
        set { subtitleLabel.text = newValue }
    }

    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 28, weight: .bold)
        $0.textAlignment = .center
        $0.layer.shadowOffset = .zero
        $0.layer.shadowRadius = 6
        $0.layer.shadowOpacity = 0.8
        $0.layer.shadowColor = UIColor.c6D59D3.cgColor
    }

    private lazy var subtitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textAlignment = .center
        $0.textColor = .white
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        add(subviews: titleLabel, subtitleLabel)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.centerX.equalToSuperview()
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(24)
        }
    }
}
