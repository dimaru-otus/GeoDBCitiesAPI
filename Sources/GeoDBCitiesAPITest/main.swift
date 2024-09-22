import OpenAPIRuntime
import OpenAPIURLSession
import Foundation
import GeoDBCitiesAPI

#if PROXY_ENABLED
let configuration = URLSessionConfiguration.default
let proxyConfiguration: [AnyHashable : Any] = [
    kCFNetworkProxiesHTTPSEnable as AnyHashable: true,
    kCFNetworkProxiesHTTPSPort as AnyHashable: 1087,
    kCFNetworkProxiesHTTPSProxy as AnyHashable: "172.16.1.6",
]

configuration.connectionProxyDictionary = proxyConfiguration
let client = Client(
    serverURL: try Servers.server1(),
    transport: URLSessionTransport(configuration: .init(session: URLSession(configuration: configuration))),
    middlewares: [
        AuthenticationMiddleware(token: BuildEnvironment.rapidApiKey),
        LoggingMiddleware(loggingPolicy: .full),
    ]
)
#else

let client = Client(
    serverURL: try Servers.server1(),
    transport: URLSessionTransport(),
    middlewares: [
        AuthenticationMiddleware(token: BuildEnvironment.rapidApiKey),
        LoggingMiddleware(loggingPolicy: .full),
    ]
)
#endif

print(try! Servers.server1())

do {
    let response = try await client.getCountriesUsingGET(query: .init(limit: 10, offset: 20))
    print(response)
} catch {
    print(error)
}
