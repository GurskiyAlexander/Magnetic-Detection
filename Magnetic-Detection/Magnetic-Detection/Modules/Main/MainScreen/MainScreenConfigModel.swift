// MARK: - MainScreenInputInterface

protocol MainScreenInputInterface: BaseInputInterface {}

// MARK: - MainScreenOutputInterface

protocol MainScreenOutputInterface: BaseOutputInterface {
    func openMagneticScreen()
    func openScanScreen()
}

// MARK: - MainScreenConfigModel

final class MainScreenConfigModel: BaseConfigModel<
    MainScreenInputInterface,
    MainScreenOutputInterface
> {
    let mainUseCase: MainUseCase

    init(output: MainScreenOutputInterface?, mainUseCase: MainUseCase) {
        self.mainUseCase = mainUseCase
        super.init(output: output)
    }
}
