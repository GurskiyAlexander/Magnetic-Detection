import UIKit
import Then
import SnapKit

// MARK: - MagneticScreenBarViewControllerInterface

protocol MagneticScreenViewControllerInterface: RootViewControllerProtocol { }

// MARK: - MagneticScreenViewController

final class MagneticScreenViewController: RootViewController<MagneticScreenViewModelInterface> {
    private var isSearching: Bool = false
    private var timer: Timer?
    private var counter: Int = .zero
    private let randomValue: Int = .random(in: 0...90)

    private lazy var imageView = UIImageView().then {
        $0.image = .magneticScreen
        $0.contentMode = .scaleAspectFill
    }

    private lazy var speedometerImageView = UIImageView().then {
        $0.image = .speedometer
        $0.contentMode = .scaleAspectFill
    }

    private let pointerBackView = UIView()

    private lazy var pointerImageView = UIImageView().then {
        $0.image = .poiner
    }

    private lazy var infoLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 17, weight: .medium)
        $0.text = "Search checking"
    }

    private lazy var searchButton = UIButton().then {
        $0.setTitle("Search", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.backgroundColor = .c6D59D3
        $0.layer.cornerRadius = 25
        $0.addTarget(self, action: #selector(didTouchButton), for: .touchUpInside)
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
        navBar.configure(type: .backWithTitle, previusName: "Main", name: "Magnetic Detection")
        navBar.backAction = { [weak self] in
            self?.viewModel.closeScreen()
        }
        pointerBackView.addSubview(pointerImageView)
        view.add(subviews: imageView, speedometerImageView, pointerBackView, infoLabel, searchButton)
    }

    private func setupConctraints() {
        imageView.snp.makeConstraints {
            $0.leading.trailing.top.width.equalToSuperview()
            $0.height.equalTo(329)
        }

        speedometerImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(imageView.snp.bottom).offset(62)
        }

        pointerBackView.snp.makeConstraints {
            $0.centerX.equalTo(speedometerImageView.snp.centerX)
            $0.centerY.equalTo(speedometerImageView.snp.bottom)
            $0.width.equalTo(pointerImageView.snp.width).multipliedBy(1.7)
        }

        pointerImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }

        infoLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(speedometerImageView.snp.bottom).offset(46)
        }

        searchButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(70)
            $0.height.equalTo(50)
        }
    }
    
    @objc
    private func didTouchButton() {
        isSearching.toggle()
        self.searchButton.animateClick { [weak self] in
            guard let self else { return }
            searchButton.setTitle(self.isSearching ? "Stop" : "Search", for: .normal)
            if isSearching {
                searching()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.timer = Timer.scheduledTimer(
                        timeInterval: 0.15,
                        target: self,
                        selector: #selector(self.searching),
                        userInfo: nil,
                        repeats: true
                    )
                }
            } else {
                timer?.invalidate()
            }
        }
    }

    @objc
    private func searching() {
        if isSearching && counter <= randomValue {
            UIView.animate(withDuration: 0.3) {
                self.infoLabel.text = "\(self.counter) µT"
                self.counter += 1
                self.pointerBackView.transform = CGAffineTransform(rotationAngle: CGFloat(self.counter) * .pi / 180 )
            }
        } else if counter > randomValue {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            UIView.animate(
                withDuration: 0.3,
                animations: {
                    self.pointerBackView.transform = CGAffineTransform(rotationAngle: CGFloat(self.counter + 1) * .pi / 180 )
                },
                completion: { _ in
                    self.pointerBackView.transform = CGAffineTransform(rotationAngle: CGFloat(self.counter - 1 ) * .pi / 180 )
                }
            )
        }
    }
}

// MARK: - MagneticScreenViewControllerInterface

extension MagneticScreenViewController: MagneticScreenViewControllerInterface { }

