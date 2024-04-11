import UIKit

// MARK: - RootViewControllerProtocol

public protocol RootViewControllerProtocol {}

open class RootViewController<ViewModel>: UIViewController, ViewControllerInterface {
    public var viewModel: ViewModel!
    let navBar = CustomNavBar()

    override open func viewDidLoad() {
        super.viewDidLoad()
        
        (viewModel as? RootViewModelProtocol)?.viewLoaded()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .c070615
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        (viewModel as? RootViewModelProtocol)?.viewAppeared()
        view.addSubview(navBar)
        navBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        (viewModel as? RootViewModelProtocol)?.viewDisappear()
    }

    open func addHideKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc
    open func hideKeyboard() {
        view.endEditing(true)
    }
}

extension RootViewController: RootViewControllerProtocol {}
