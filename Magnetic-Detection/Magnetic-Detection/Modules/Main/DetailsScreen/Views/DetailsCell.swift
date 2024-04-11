import UIKit

// MARK: - DetailsCell

final class DetailsCell: UITableViewCell {

    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17, weight: .regular)
        $0.textColor = .white
    }

    private lazy var subtitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17, weight: .regular)
        $0.textColor = .c525878
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

        contentView.add(subviews: titleLabel, subtitleLabel)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(48)
            $0.leading.equalToSuperview().inset(16)
        }

        subtitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}

// MARK: - ResultCell

extension DetailsCell: ConfigurableView {
    struct Model {
        var title: String
        var description: String
    }

    func configure(with model: Model) {
        titleLabel.text = model.title
        subtitleLabel.text = model.description
    }
}
