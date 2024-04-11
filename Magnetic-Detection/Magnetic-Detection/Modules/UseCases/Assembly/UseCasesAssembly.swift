// MARK: - UseCasesAssembly

protocol UseCasesAssembly {
    var mainUseCase: MainUseCase { get }
}

// MARK: - UseCasesAssemblyImpl

class UseCasesAssemblyImpl: UseCasesAssembly {
    lazy var mainUseCase: MainUseCase = MainUseCaseImpl(
        secure: propertiesAssembly.secureService,
        unsecure: propertiesAssembly.unsecureService
    )

    private let propertiesAssembly: PropertiesAssembly

    public convenience init() {
        self.init(
            propertiesAssembly: PropertiesAssemblyImpl()
        )
    }

    init(propertiesAssembly: PropertiesAssembly) {
        self.propertiesAssembly = propertiesAssembly
    }
}
