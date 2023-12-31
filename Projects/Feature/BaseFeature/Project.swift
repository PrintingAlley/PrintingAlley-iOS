import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.BaseFeature.rawValue,
    targets: [
        .interface(module: .feature(.BaseFeature) , dependencies: [
            .domain(target: .BaseDomain, type: .interface)
        ]),
        .implements(module: .feature(.BaseFeature), dependencies: [
            .shared(target: .UtilityModule),
            .feature(target: .BaseFeature,type:.interface),
            .feature(target: .BookMarkFeature, type: .interface),
            .domain(target: .BookMarkDomain, type: .interface),
            .domain(target: .UserDomain, type: .interface),
            .domain(target: .ProductDomain, type: .interface),
            .domain(target: .PrintShopDomain, type: .interface),
            .core(target: .Network),
            
        ]),
        .tests(module: .feature(.BaseFeature), dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .demo(module: .feature(.BaseFeature), dependencies: [
            .feature(target: .BaseFeature)
        ])
        
    ]
)
