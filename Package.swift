// swift-tools-version: 5.10

import PackageDescription

let package = Package(
   name: "GeoDBCitiesAPI",
   platforms: [.macOS(.v10_15)],
   products: [
    .library(name: "GeoDBCitiesAPI", targets: ["GeoDBCitiesAPI"]),
   ],
   dependencies: [
    .package(url: "https://github.com/apple/swift-openapi-generator", from: "1.0.0"),
    .package(url: "https://github.com/apple/swift-openapi-runtime", from: "1.0.0"),
    .package(url: "https://github.com/apple/swift-openapi-urlsession", from: "1.0.0"),
    .package(url: "https://github.com/apple/swift-http-types", from: "1.0.2"),
    .package(url: "https://github.com/DimaRU/BuildEnvironment", branch: "master"),
   ],
    targets: [
        .target(
            name: "GeoDBCitiesAPI",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
                .product(name: "HTTPTypes", package: "swift-http-types"),
            ],
            plugins: [
                .plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator"),
            ]
        ),
        .executableTarget(
            name: "GeoDBCitiesAPITest",
            dependencies: ["GeoDBCitiesAPI"],
            plugins: [
                .plugin(name: "BuildEnvPlugin", package: "BuildEnvironment")
            ]
        )
    ]
)
