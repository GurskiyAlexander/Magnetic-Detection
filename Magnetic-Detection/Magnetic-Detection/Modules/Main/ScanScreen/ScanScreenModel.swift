import UIKit

// MARK: - ScanScreenViewModelInterface

protocol ScanScreenViewModelInterface: RootViewModelProtocol {
    func setFindingDevices(count: Int)
}

// MARK: - ScanScreenViewModel

final class ScanScreenViewModel: RootViewModel<
    ScanScreenViewController,
    ScanScreenConfigModel
> {

    override func viewLoaded() {
        super.viewLoaded()

        getData()
    }

    private func getData() {
        let model = config.mainUseCase.currentNetwork
        controller.configure(with: model)
    }
}

// MARK: - ScanScreenViewModelInterface

extension ScanScreenViewModel: ScanScreenViewModelInterface {
    func setFindingDevices(count: Int) {
        config.mainUseCase.counterFindingDevices = count
        config.output?.openResultScreen()
    }
}

// MARK: - ScanScreenInputInterface

extension ScanScreenViewModel: ScanScreenInputInterface {}
