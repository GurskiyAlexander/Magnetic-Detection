import UIKit
import Then
import SnapKit
import Lottie

// MARK: - ScanScreenBarViewControllerInterface

protocol ScanScreenViewControllerInterface: RootViewControllerProtocol {
    func configure(with model: String)
}

// MARK: - ScanScreenViewController

final class ScanScreenViewController: RootViewController<ScanScreenViewModelInterface> {
    private var timer: Timer?
    private var counterFindingDevices: Int = .zero
    private var counter: Int = .zero
    private lazy var animationView = LottieAnimationView(name: "search").then {
        $0.contentMode = .scaleAspectFit
        $0.loopMode = .loop
    }

    private lazy var titleLabel = UILabel().then {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.text = "Scanning Your Wi-Fi"
    }

    private lazy var subtitleLabel = UILabel().then {
        $0.textColor = .c6D59D3
        $0.textAlignment = .center
        $0.numberOfLines = .zero
        $0.font = .systemFont(ofSize: 28, weight: .bold)
    }

    private lazy var counterLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 17, weight: .semibold)
        $0.text = "0%"
    }

    private lazy var mainButton = UIButton().then {
        $0.setTitle("Stop", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.backgroundColor = .c6D59D3
        $0.layer.cornerRadius = 25
        $0.addTarget(self, action: #selector(didTouchButton), for: .touchUpInside)
    }

    private let counterDevicesLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConctraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        animationView.play()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setupCounterLabel()
    }

    private func setupUI() {
        navBar.isHidden = true

        view.add(subviews: animationView, titleLabel, subtitleLabel, counterLabel, counterDevicesLabel, mainButton)
    }

    private func setupConctraints() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }

        subtitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom)
        }

        animationView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(70)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(animationView.snp.width)
            $0.centerY.equalToSuperview()
        }

        counterLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        counterDevicesLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(animationView.snp.bottom).offset(32)
        }

        mainButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(36)
            $0.height.equalTo(50)
        }
    }

    private func setupCounterLabel() {
        timer = Timer.scheduledTimer(
            timeInterval: 0.05,
            target: self,
            selector: #selector(scan),
            userInfo: nil,
            repeats: true
        )
    }

    @objc
    private func scan() {
        counter += 1
        self.counterLabel.text = "\(counter)%"
        if counter == 100 {
            timer?.invalidate()
            self.viewModel.setFindingDevices(count: self.counterFindingDevices)
            return
        }
        if counter.isMultiple(of: 10) {
            self.counterFindingDevices = counter / 10 * 3 + 1
            let string = "\(self.counterFindingDevices)  Devices Found..."
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 17, weight: .semibold)
            ]
            let attributedString = NSMutableAttributedString(string: string, attributes: attributes)
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 28, weight: .bold), range: NSRange(location: 0, length: 2))
            attributedString.addAttribute(.foregroundColor, value: UIColor.c6D59D3, range: NSRange(location: 0, length: 2))
            self.counterDevicesLabel.attributedText = attributedString
        }
    }

    @objc
    private func didTouchButton() {
        mainButton.animateClick { [weak self] in
            guard let self else { return }
            timer?.invalidate()
            viewModel.setFindingDevices(count: counterFindingDevices)
        }
    }
}

// MARK: - ScanScreenViewControllerInterface

extension ScanScreenViewController: ScanScreenViewControllerInterface {
    func configure(with model: String) {
        subtitleLabel.text = model
    }
}

