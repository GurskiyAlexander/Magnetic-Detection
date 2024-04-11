import UIKit
import Then
import SnapKit
import Lottie

// MARK: - ResultScreenBarViewControllerInterface

protocol ResultScreenViewControllerInterface: RootViewControllerProtocol {
    func configure(with model: ResultModel)
}

// MARK: - ResultScreenViewController

final class ResultScreenViewController: RootViewController<ResultScreenViewModelInterface> {
    private let counterDevicesLabel = UILabel()

    private lazy var nameLabel = UILabel().then {
        $0.textColor = .c525878
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textAlignment = .center
    }

    private lazy var tableView = UITableView().then {
        $0.backgroundColor = .c100D2C
        $0.layer.cornerRadius = 8
        $0.delegate = self
        $0.dataSource = self
        $0.showsVerticalScrollIndicator = false
        $0.separatorColor = .c525878
        $0.register(class: ResultCell.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConctraints()
    }

    private func setupUI() {
        navBar.configure(type: .standart, name: "Result")
        navBar.backAction = { [weak self] in
            self?.viewModel.openMain()
        }
        view.add(subviews: counterDevicesLabel, nameLabel, tableView)
    }

    private func setupConctraints() {
        counterDevicesLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(58)
            $0.centerX.equalToSuperview()
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(counterDevicesLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }

        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(nameLabel.snp.bottom).offset(32)
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - ResultScreenViewControllerInterface

extension ResultScreenViewController: ResultScreenViewControllerInterface {
    func configure(with model: ResultModel) {
        let string = "\(model.countDevices) Devices"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 28, weight: .bold)
        ]
        let attributedString = NSMutableAttributedString(string: string, attributes: attributes)
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 28, weight: .bold), range: NSRange(location: 0, length: 2))
        attributedString.addAttribute(.foregroundColor, value: UIColor.c6D59D3, range: NSRange(location: 0, length: 2))
        self.counterDevicesLabel.attributedText = attributedString

        nameLabel.text = model.currentNetworkName
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension ResultScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.openDetails(model: viewModel.dataSource[indexPath.item])
    }
}

// MARK: - UITableViewDataSource

extension ResultScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(reusable: ResultCell.self)
        cell.configure(with: viewModel.dataSource[indexPath.row])
        cell.separatorInset.left = -10
        cell.selectionStyle = .none
        return cell
    }
}
