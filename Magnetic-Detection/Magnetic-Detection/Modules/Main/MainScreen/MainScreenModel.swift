import UIKit

// MARK: - MainScreenViewModelInterface

protocol MainScreenViewModelInterface: RootViewModelProtocol {
    var dataSource: [ActionCell.Model] { get }

    func didTapedCell(type: ActionCellType)
    func openScanScreen()
}

// MARK: - MainScreenViewModel

final class MainScreenViewModel: RootViewModel<
    MainScreenViewController,
    MainScreenConfigModel
> {
    var dataSource = [ActionCell.Model]()

    override func viewLoaded() {
        super.viewLoaded()

        getData()
    }

    override func viewAppeared() {
        super.viewAppeared()

    }

    private func getData() {
        let model = config.mainUseCase.getCurrentNetwork()
        dataSource = model.cells
        controller.configure(with: model)
    }
}

// MARK: - MainScreenViewModelInterface

extension MainScreenViewModel: MainScreenViewModelInterface {
    func didTapedCell(type: ActionCellType) {
        switch type {

            case .infrared:
                print("infrared")
            case .bluetooth:
                print("bluetooth")
            case .magnetic:
                config.output?.openMagneticScreen()
            case .tips:
                print("tips")
        }
    }

    func openScanScreen() {
        config.output?.openScanScreen()
    }
}

// MARK: - MainScreenInputInterface

extension MainScreenViewModel: MainScreenInputInterface {}
