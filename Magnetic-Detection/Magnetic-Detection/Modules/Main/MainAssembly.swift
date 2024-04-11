import UIKit

// MARK: - BaseAssembly

protocol MainAssemblyProtocol: BaseAssemblyProtocol {
    var rootAssembly: RootAssemblyProtocol { get }
    
    func makeMain(output: MainScreenOutputInterface) -> MainScreenViewController
    func makeMagnetic(output: MagneticScreenOutputInterface) -> MagneticScreenViewController
    func makeScan(output: ScanScreenOutputInterface) -> ScanScreenViewController
    func makeResult(output: ResultScreenOutputInterface) -> ResultScreenViewController
    func makeDetails(output: DetailsScreenOutputInterface, model: ResultCell.Model) -> DetailsScreenViewController
}

// MARK: - MainAssembly

final class MainAssembly: BaseAssemblyProtocol {

    private var mainCoordinator: MainCoordinator!
    private let useCasesAssembly: UseCasesAssembly
    let rootAssembly: RootAssemblyProtocol
    let window: UIWindow

    init(
        window: UIWindow,
        useCasesAssembly: UseCasesAssembly = UseCasesAssemblyImpl(),
        rootAssembly: RootAssemblyProtocol = RootAssembly()
    ) {
        self.useCasesAssembly = useCasesAssembly
        self.window = window
        self.rootAssembly = rootAssembly
    }

    @available(*, unavailable)
    required init() {
        fatalError("init() has not been implemented")
    }

    func coordinator() -> BaseCoordinator {
        mainCoordinator = MainCoordinator(assembly: self)
        return mainCoordinator
    }
}

// MARK: - MainAssembly

extension MainAssembly: MainAssemblyProtocol {

    func makeMain(output: MainScreenOutputInterface) -> MainScreenViewController {
        MainScreenSceneAssembly(
            config: MainScreenConfigModel(
                output: output,
                mainUseCase: useCasesAssembly.mainUseCase
            )
        ).controller!
    }

    func makeMagnetic(output: MagneticScreenOutputInterface) -> MagneticScreenViewController {
        MagneticScreenSceneAssembly(
            config: MagneticScreenConfigModel(
                output: output,
                mainUseCase: useCasesAssembly.mainUseCase
            )
        ).controller!
    }

    func makeScan(output: ScanScreenOutputInterface) -> ScanScreenViewController {
        ScanScreenSceneAssembly(
            config: ScanScreenConfigModel(
                output: output,
                mainUseCase: useCasesAssembly.mainUseCase
            )
        ).controller!
    }

    func makeResult(output: ResultScreenOutputInterface) -> ResultScreenViewController {
        ResultScreenSceneAssembly(
            config: ResultScreenConfigModel(
                output: output,
                mainUseCase: useCasesAssembly.mainUseCase
            )
        ).controller!
    }

    func makeDetails(output: DetailsScreenOutputInterface, model: ResultCell.Model) -> DetailsScreenViewController {
        DetailsScreenSceneAssembly(
            config: DetailsScreenConfigModel(
                output: output,
                mainUseCase: useCasesAssembly.mainUseCase,
                model: model
            )
        ).controller!
    }
}
