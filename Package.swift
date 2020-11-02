// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

/**
 * Copyright IBM Corporation 2016, 2017, 2019
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import PackageDescription
import Foundation

var dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/Kitura-Next/Kitura.git", from: "2.6.0"),
    .package(url: "https://github.com/Kitura-Next/HeliumLogger.git", from: "1.7.1"),
    .package(url: "https://github.com/Kitura-Next/CloudEnvironment.git", from: "9.0.0"),
    .package(url: "https://github.com/Kitura-Next/SwiftMetrics.git", from: "2.5.0"),
    .package(url: "https://github.com/Kitura-Next/Health.git", from: "1.0.0"),
    .package(url: "https://github.com/Kitura-Next/Kitura-OpenAPI.git", from: "1.1.0"),
    .package(url: "https://github.com/Kitura-Next/Kitura-StencilTemplateEngine.git", from: "1.9.0"),
    .package(url: "https://github.com/Kitura-Next/Kitura-Markdown.git", from: "1.0.0"),
    .package(url: "https://github.com/Kitura-Next/Kitura-CredentialsHTTP.git", from: "2.1.0"),
    .package(url: "https://github.com/Kitura-Next/Kitura-Session.git", from: "3.3.0"),
    .package(url: "https://github.com/Kitura-Next/Kitura-CredentialsGoogle.git", from: "2.2.0"),
    .package(url: "https://github.com/Kitura-Next/Kitura-CredentialsFacebook.git", from: "2.2.0"),
    .package(url: "https://github.com/Kitura-Next/Swift-JWT", from: "3.0.0"),
    .package(url: "https://github.com/Kitura-Next/Swift-Kuery-ORM.git", from: "0.5.0"),
]
var targetDependencies: [Target.Dependency] = [ "Kitura", "CloudEnvironment","SwiftMetrics","Health", "KituraOpenAPI", "KituraMarkdown", "KituraStencil", "CredentialsHTTP", "KituraSession", "CredentialsGoogle", "CredentialsFacebook", "SwiftJWT", "SwiftKueryORM",
]

// Uncomment to use PostgreSQL
// dependencies.append(.package(url: "https://github.com/Kitura-Next/Swift-Kuery-PostgreSQL.git", from: "1.2.0"))
// targetDependencies.append("SwiftKueryPostgreSQL")

// IBMCloudAppID requires OpenSSL that is not included on Mac by default.
#if os(Linux)
dependencies.append(.package(url: "https://github.com/ibm-cloud-security/appid-serversdk-swift", from: "5.1.0"))
targetDependencies.append("IBMCloudAppID")
#endif

// Use alternate implementation of Kitura-WebSocket while building in NIO mode
if ProcessInfo.processInfo.environment["KITURA_NIO"] != nil {
    dependencies.append(.package(url:  "https://github.com/Kitura-Next/Kitura-WebSocket-NIO.git", from: "2.0.0"))
} else {
    dependencies.append(.package(url: "https://github.com/Kitura-Next/Kitura-WebSocket.git", from: "2.0.0"))
}

let package = Package(
    name: "Kitura-Sample",
    dependencies: dependencies,
    targets: [
        .target(name: "Kitura-Sample", dependencies: [ .target(name: "Application"), .target(name: "ChatService"), "Kitura" , "HeliumLogger"]),
        .target(name: "Application", dependencies: targetDependencies),
        .target(name: "ChatService", dependencies: ["Kitura-WebSocket"]),
        .testTarget(name: "KituraSampleRouterTests" , dependencies: [.target(name: "Application"), "Kitura","HeliumLogger" ])
    ]
)
