// MARK: - ResultScreenInputInterface

protocol ResultScreenInputInterface: BaseInputInterface {}

// MARK: - ResultScreenOutputInterface

protocol ResultScreenOutputInterface: BaseOutputInterface {
    func closeScreen()
    func openDetailsScreen(model: ResultCell.Model)
}

// MARK: - ResultScreenConfigModel

final class ResultScreenConfigModel: BaseConfigModel<
    ResultScreenInputInterface,
    ResultScreenOutputInterface
> {
    let mainUseCase: MainUseCase

    init(output: ResultScreenOutputInterface?, mainUseCase: MainUseCase) {
        self.mainUseCase = mainUseCase
        super.init(output: output)
    }
}
