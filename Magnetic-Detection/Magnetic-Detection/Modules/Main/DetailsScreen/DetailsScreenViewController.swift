import UIKit
import Then
import SnapKit
import Lottie

// MARK: - DetailsScreenBarViewControllerInterface

protocol DetailsScreenViewControllerInterface: RootViewControllerProtocol {
    func configure(with model: DetailsModel)
}

// MARK: - DetailsScreenViewController

final class DetailsScreenViewController: RootViewController<DetailsScreenViewModelInterface> {
    private lazy var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }

    private let headerView = HeaderView()

    private lazy var tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.dataSource = self
        $0.showsVerticalScrollIndicator = false
        $0.separatorColor = .c525878
        $0.isUserInteractionEnabled = false
        $0.register(class: DetailsCell.self)
    }

    private lazy var backView = UIView().then {
        $0.backgroundColor = .c100D2C
        $0.layer.cornerRadius = 8
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConctraints()
        tableView.layoutIfNeeded()
    }

    private func setupUI() {
        navBar.configure(type: .standart, name: "Device Details")
        navBar.backAction = { [weak self] in
            self?.viewModel.openMain()
        }
        backView.add(subviews: headerView, tableView)
        view.add(subviews: imageView, backView)
    }

    private func setupConctraints() {
        imageView.snp.makeConstraints {
            $0.leading.trailing.top.width.equalToSuperview()
            $0.height.equalTo(329)
        }

        backView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(280)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(300)
        }

        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(108)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(18)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(192)
        }
    }
}

// MARK: - DetailsScreenViewControllerInterface

extension DetailsScreenViewController: DetailsScreenViewControllerInterface {
    func configure(with model: DetailsModel) {
        imageView.image = model.isNorm ? .detailsNorm : .detailsFail
        tableView.reloadData()
        headerView.isFail = !model.isNorm
        headerView.title = model.currentNetworkName
        headerView.subtitle = model.ip
    }
}

// MARK: - UITableViewDelegate

extension DetailsScreenViewController: UITableViewDelegate { }

// MARK: - UITableViewDataSource

extension DetailsScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(reusable: DetailsCell.self)
        cell.configure(with: viewModel.dataSource[indexPath.row])
        cell.separatorInset.left = -10
        cell.selectionStyle = .none
        return cell
    }
}
