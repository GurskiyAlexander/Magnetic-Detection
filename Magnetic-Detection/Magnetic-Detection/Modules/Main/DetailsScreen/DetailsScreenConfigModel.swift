// MARK: - DetailsScreenInputInterface

protocol DetailsScreenInputInterface: BaseInputInterface {}

// MARK: - DetailsScreenOutputInterface

protocol DetailsScreenOutputInterface: BaseOutputInterface {
    func closeScreen()
}

// MARK: - DetailsScreenConfigModel

final class DetailsScreenConfigModel: BaseConfigModel<
    DetailsScreenInputInterface,
    DetailsScreenOutputInterface
> {
    let mainUseCase: MainUseCase
    let model: ResultCell.Model

    init(output: DetailsScreenOutputInterface?, mainUseCase: MainUseCase, model: ResultCell.Model) {
        self.mainUseCase = mainUseCase
        self.model = model
        super.init(output: output)
    }
}
