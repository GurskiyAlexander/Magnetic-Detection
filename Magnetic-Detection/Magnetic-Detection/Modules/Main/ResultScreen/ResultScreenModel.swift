import UIKit

// MARK: - ResultScreenViewModelInterface

protocol ResultScreenViewModelInterface: RootViewModelProtocol {
    var dataSource: [ResultCell.Model] { get }

    func openMain()
    func openDetails(model: ResultCell.Model)
}

// MARK: - ResultScreenViewModel

final class ResultScreenViewModel: RootViewModel<
    ResultScreenViewController,
    ResultScreenConfigModel
> {
    var dataSource: [ResultCell.Model] = []

    override func viewLoaded() {
        super.viewLoaded()

        getData()
    }

    private func getData() {
        let model = config.mainUseCase.getDevices()
        dataSource = model.cellModels
        controller.configure(with: model)
    }
}

// MARK: - ResultScreenViewModelInterface

extension ResultScreenViewModel: ResultScreenViewModelInterface {
    func openMain() {
        config.output?.closeScreen()
    }

    func openDetails(model: ResultCell.Model) {
        config.output?.openDetailsScreen(model: model)
    }
}

// MARK: - ResultScreenInputInterface

extension ResultScreenViewModel: ResultScreenInputInterface {}
