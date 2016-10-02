import PackageDescription

let package = Package(
    name: "StripeSwift",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1)
    ]
)
