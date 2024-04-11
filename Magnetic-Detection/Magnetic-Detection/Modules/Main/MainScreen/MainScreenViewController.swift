import UIKit
import Then
import SnapKit

// MARK: - MainScreenBarViewControllerInterface

protocol MainScreenViewControllerInterface: RootViewControllerProtocol {
    func configure(with model: CurrentNetwork)
}

// MARK: - MainScreenViewController

final class MainScreenViewController: RootViewController<MainScreenViewModelInterface> {
    private lazy var scrollView = UIScrollView().then {
        $0.contentInsetAdjustmentBehavior = .never
        $0.contentInset.bottom = -18
        $0.showsVerticalScrollIndicator = false
    }

    private lazy var imageView = UIImageView().then {
        $0.image = .mainScreen
        $0.contentMode = .scaleAspectFill
    }

    private let currentNetworkView = CurrentNetworkView()

    private lazy var layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumInteritemSpacing = 12
        $0.minimumLineSpacing = 30
    }

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.delegate = self
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        $0.clipsToBounds = false
        $0.dataSource = self
        $0.register(class: ActionCell.self)
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
        view.addSubview(scrollView)
        navBar.configure(type: .righButton)
        scrollView.add(subviews: imageView, currentNetworkView, collectionView)
        currentNetworkView.action = { [weak self] in
            self?.viewModel.openScanScreen()
        }
    }

    private func setupConctraints() {
        scrollView.snp.makeConstraints {
            $0.edges.size.equalToSuperview()
        }

        imageView.snp.makeConstraints {
            $0.leading.trailing.top.width.equalToSuperview()
            $0.height.equalTo(329)
        }

        currentNetworkView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(280)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(currentNetworkView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(36)
            $0.height.equalTo(358)
            $0.bottom.equalToSuperview()//.inset(20)
        }
    }
}

// MARK: - MainScreenViewControllerInterface

extension MainScreenViewController: MainScreenViewControllerInterface {
    func configure(with model: CurrentNetwork) {
        currentNetworkView.configure(with: model.name)
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate

extension MainScreenViewController: UICollectionViewDelegate { }

// MARK: - UICollectionViewDataSource

extension MainScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: ActionCell.self, for: indexPath)
        cell.configure(with: viewModel.dataSource[indexPath.item])
        cell.action = { [weak self] in
            self?.viewModel.didTapedCell(type: $0)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (collectionView.frame.width - 20) / 2
        return CGSize(width: width, height: width)
    }
}
