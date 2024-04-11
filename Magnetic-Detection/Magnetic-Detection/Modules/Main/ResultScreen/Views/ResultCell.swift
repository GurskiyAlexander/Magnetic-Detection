import UIKit

// MARK: - ResultCell

final class ResultCell: UITableViewCell {
    private lazy var networkStatusImageView = UIImageView().then {
        $0.clipsToBounds = true
    }

    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17, weight: .medium)
        $0.textColor = .white
    }

    private lazy var subtitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .medium)
        $0.textColor = .c525878
    }

    private lazy var arrowImageView = UIImageView().then {
        $0.image = .arrowRight
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() { 
        contentView.backgroundColor = .clear
        backgroundColor = .clear

        contentView.add(subviews: networkStatusImageView, titleLabel, subtitleLabel, arrowImageView)
    }

    private func setupConstraints() {
        networkStatusImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(networkStatusImageView.snp.trailing).offset(16)
            $0.top.equalToSuperview().offset(7)
        }

        subtitleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(7)
        }

        arrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}

// MARK: - ResultCell

extension ResultCell: ConfigurableView {
    struct Model {
        var networkImage: UIImage
        var name: String
        var ipAddress: String
        var isNorm: Bool
    }

    func configure(with model: Model) {
        networkStatusImageView.image = model.networkImage
        titleLabel.text = model.name
        subtitleLabel.text = model.ipAddress
    }
}
