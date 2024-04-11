import UIKit

// MARK: - DetailsScreenViewModelInterface

protocol DetailsScreenViewModelInterface: RootViewModelProtocol {
    var dataSource: [DetailsCell.Model] { get }

    func openMain()
}

// MARK: - DetailsScreenViewModel

final class DetailsScreenViewModel: RootViewModel<
    DetailsScreenViewController,
    DetailsScreenConfigModel
> {
    var dataSource: [DetailsCell.Model] = []

    override func viewLoaded() {
        super.viewLoaded()

        getData()
    }

    func getData() {
        let data = config.mainUseCase.getDetailsInfo(with: config.model)
        dataSource = data.cellModels
        controller.configure(with: data)
    }
}

// MARK: - DetailsScreenViewModelInterface

extension DetailsScreenViewModel: DetailsScreenViewModelInterface {
    func openMain() {
        config.output?.closeScreen()
    }
}

// MARK: - DetailsScreenInputInterface

extension DetailsScreenViewModel: DetailsScreenInputInterface {}
