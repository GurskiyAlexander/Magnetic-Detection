// MARK: - MagneticScreenInputInterface

protocol MagneticScreenInputInterface: BaseInputInterface {}

// MARK: - MagneticScreenOutputInterface

protocol MagneticScreenOutputInterface: BaseOutputInterface {
    func closeScreen()
}

// MARK: - MagneticScreenConfigModel

final class MagneticScreenConfigModel: BaseConfigModel<
    MagneticScreenInputInterface,
    MagneticScreenOutputInterface
> {
    let mainUseCase: MainUseCase

    init(output: MagneticScreenOutputInterface?, mainUseCase: MainUseCase) {
        self.mainUseCase = mainUseCase
        super.init(output: output)
    }
}
