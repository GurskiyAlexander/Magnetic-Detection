import UIKit

enum ActionCellType {
    case infrared
    case bluetooth
    case magnetic
    case tips
}

final class ActionCell: UICollectionViewCell {
    var action: ((ActionCellType) -> Void)?

    private var type: ActionCellType = .infrared

    private lazy var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }

    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17, weight: .medium)
        $0.textAlignment = .center
        $0.textColor = .white
        $0.numberOfLines = .zero
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
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTaped))
        contentView.addGestureRecognizer(gesture)
        contentView.layer.shadowColor = UIColor.c23175F.cgColor
        contentView.layer.shadowRadius = 28
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = .zero
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .c23175F
        contentView.add(subviews: imageView, titleLabel)
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(24)
        }
    }

    @objc
    private func didTaped() {
        animateClick { [weak self] in
            guard let self else { return }
            self.action?(type)
        }
    }
}

extension ActionCell: ConfigurableView {
    struct Model {
        var type: ActionCellType
        var image: UIImage?
        var title: String
    }

    func configure(with model: Model) {
        imageView.image = model.image
        titleLabel.text = model.title
        type = model.type
    }
}
