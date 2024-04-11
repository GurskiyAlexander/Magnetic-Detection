import UIKit

// MARK: - MagneticScreenViewModelInterface

protocol MagneticScreenViewModelInterface: RootViewModelProtocol {
    func closeScreen()
}

// MARK: - MagneticScreenViewModel

final class MagneticScreenViewModel: RootViewModel<
    MagneticScreenViewController,
    MagneticScreenConfigModel
> {}

// MARK: - MagneticScreenViewModelInterface

extension MagneticScreenViewModel: MagneticScreenViewModelInterface {
    func closeScreen() {
        config.output?.closeScreen()
    }
}

// MARK: - MagneticScreenInputInterface

extension MagneticScreenViewModel: MagneticScreenInputInterface {}
