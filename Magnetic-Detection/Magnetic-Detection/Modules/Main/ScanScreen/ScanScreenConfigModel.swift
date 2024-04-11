// MARK: - ScanScreenInputInterface

protocol ScanScreenInputInterface: BaseInputInterface {}

// MARK: - ScanScreenOutputInterface

protocol ScanScreenOutputInterface: BaseOutputInterface {
    func closeScreen()
    func openResultScreen()
}

// MARK: - ScanScreenConfigModel

final class ScanScreenConfigModel: BaseConfigModel<
    ScanScreenInputInterface,
    ScanScreenOutputInterface
> {
    var mainUseCase: MainUseCase

    init(output: ScanScreenOutputInterface?, mainUseCase: MainUseCase) {
        self.mainUseCase = mainUseCase
        super.init(output: output)
    }
}
