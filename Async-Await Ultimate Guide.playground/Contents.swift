import Foundation
import PlaygroundSupport
import SwiftUI


// Agenda

// MARK: - Closures (old)
// MARK: - "async / await" basics (new)
// MARK: - Flow
// MARK: - async get
// MARK: - async let
// MARK: - Task
// MARK: - TaskGroup
// MARK: - withCheckedContinuation
// MARK: - Saved Continuation
// MARK: - AsyncSequence
// MARK: - Thread Explosion
// MARK: - Actor
// MARK: - SwiftUI + task



// MARK: - Closures (old)



//func fetch<T: Decodable>(request: Request, completion: @escaping (Result<T, Error>) -> Void) {
//    print("start fetch \(request)\n")
//    defer { print("end fetch \(request)\n") }
//    guard let url: URL = request.url else {
//        completion(.failure(URLError(.badURL)))
//        return
//    }
//    let task: URLSessionDataTask = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
//        guard error == nil else {
//            completion(.failure(URLError(.badServerResponse)))
//            return
//        }
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
//            completion(.failure(URLError(.badServerResponse)))
//            return
//        }
//        guard let data: Data = data else {
//            completion(.failure(URLError(.dataNotAllowed)))
//            return
//        }
//        do {
//            let result: T = try JSONDecoder().decode(T.self, from: data)
//            completion(.success(result))
//        } catch {
//            completion(.failure(URLError(.cannotDecodeContentData)))
//        }
//    }
//    task.resume()
//}
//
//fetch(request: .photos) { (result: Result<[Photo], Error>) in
//    switch result {
//    case .failure(let error): print(error)
//    case .success(let photos): print(photos.prefix(5))
//    }
//}



// MARK: - "async / await" basics (new)



//func fetch<T: Decodable>(request: Request) async throws -> T {
//    print("start fetch \(request)\n")
//    defer { print("end fetch \(request)\n") }
//    guard let url: URL = request.url else { throw URLError(.badURL) }
//    let (data, response) = try await URLSession.shared.data(from: url)
//    guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw URLError(.badServerResponse) }
//    return try JSONDecoder().decode(T.self, from: data)
//}
//
//var photos: [Photo] = []
//
//Task {
//    do {
//        let result: [Photo] = try await fetch(request: .photos)
//        photos = result.prefix(20).map { $0 }
////        print(photos)
//    } catch {
//        print(error)
//    }
//}
//Thread.sleep(forTimeInterval: 1.0)
//print("[End basics]\n")



// MARK: - Flow



/*
 https://cdn.sparrowcode.io/tutorials/async-await/set-image-scheme.png
*/



// MARK: - async get



//final class MyClass {
//
//    var value: Int {
//        get async {
//            return await valueAsync()
//        }
//    }
//
////    var value2: Int {
////        get async {
////            return await valueAsync()
////        }
////        set { // ERROR
////            value2 = newValue
////        }
////    }
//
////    async let value3: Int = 3 // ERROR
//
//    private func valueAsync() async -> Int {
//        try? await Task.sleep(for: .seconds(1))
//        return Int.random(in: (0...10))
//    }
//}
//
//let myClass: MyClass = MyClass()
//Task { print(await myClass.value) }



// MARK: - async let



//Task {
//    do {
//        let result1: [User] = try await fetch(request: .users)
//        let result2: [Photo] = try await fetch(request: .photos)
//        let array: [[Any]] = [
//            result1.prefix(5).map { $0 },
//            result2.prefix(5).map { $0 },
//        ]
//        print(array)
//    } catch {
//        print(error)
//    }
//}

//Task {
//    do {
//        async let result1: [User] = fetch(request: .users)
//        async let result2: [Photo] = fetch(request: .photos)
//        let array: [[Any]] = try await [
//            result1.prefix(5).map { $0 },
//            result2.prefix(5).map { $0 },
//        ]
////        let array: [[Any]] = try [
////            await result1.prefix(5).map { $0 },
////            await result2.prefix(5).map { $0 },
////        ]
////        let array: [[Any]] = [
////            try await result1.prefix(5).map { $0 },
////            try await result2.prefix(5).map { $0 },
////        ]
//        print(array)
//    } catch {
//        print(error)
//    }
//}



// MARK: - Task



/*
 - Tasks are structs!
 - Tasks will start immediately after creation!
 - Tasks returns result!
*/

//Task {
//    let insideTask = Task {
//        // any async work
//        let flag: Bool = Bool.random()
//        if flag {
//            return 0
//        } else {
//            throw URLError(.badURL)
//        }
//    }
//    let result = await insideTask.result
//    print(result)
//}

//Task {
//    let insideTask = Task {
//        // any async work
//        let flag: Bool = Bool.random()
//        if flag {
//            return 0
//        } else {
//            throw URLError(.badURL)
//        }
//    }
//    do {
//        print(try await insideTask.value)
//    } catch {
//        print(error)
//    }
//}

//Task {
//    let insideTask = Task {
//        // any async work
//        print("before cancel check")
//        try await Task.sleep(for: .seconds(1.0))
//        guard !Task.isCancelled else { throw URLError(.cancelled) }
//        print("after cancel check")
//        let flag: Bool = Bool.random()
//        if flag {
//            return 0
//        } else {
//            throw URLError(.badURL)
//        }
//    }
//    insideTask.cancel()
//    print(await insideTask.result)
//}

//Task(priority: .high) {}
//TaskPriority.high.rawValue
//TaskPriority.userInitiated.rawValue
//TaskPriority.medium.rawValue
//TaskPriority.low.rawValue
//TaskPriority.utility.rawValue
//TaskPriority.background.rawValue

//Task.detached {
//    // some async work here
//}



// MARK: - TaskGroup



//func fetchData(request: Request) async throws -> Data {
//    print("start fetch \(request)\n")
//    defer { print("end fetch \(request)\n") }
//    guard let url: URL = request.url else { throw URLError(.badURL) }
//    let (data, response) = try await URLSession.shared.data(from: url)
//    guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw URLError(.badServerResponse) }
//    return data
//}

//Task {
//    do {
//        let start = CFAbsoluteTimeGetCurrent()
//        var images: [Image] = []
//        for url in photos.map(\.url) {
//            let task = Task {
//                try await Task.sleep(for: .seconds(0.3))
//                let data: Data = try await fetchData(request: .own(urlString: url))
//                return Image(uiImage: UIImage(data: data)!)
//            }
//            images.append(try await task.value)
//        }
//        var myView: any View {
//            ScrollView {
//                ForEach((0 ..< images.count), id: \.self) { index in
//                    ZStack {
//                        images[index]
//                            .resizable()
//                            .frame(width: 200.0, height: 200.0)
//                        Text("\(photos[index].id)")
//                    }
//                }
//            }
//        }
//        let diff = CFAbsoluteTimeGetCurrent() - start
//        print("Took \(diff) seconds")
//        DispatchQueue.main.async {
//            print("main")
//            PlaygroundPage.current.setLiveView(myView)
//        }
//    } catch {
//        print(error)
//    }
//}

//Task {
//    do {
//        let start = CFAbsoluteTimeGetCurrent()
//        var images: [Image] = []
//        try await withThrowingTaskGroup(of: Data.self) { group in
//            for url in photos.map(\.url) {
//                group.addTask {
//                    try await Task.sleep(for: .seconds(0.3))
//                    return try await fetchData(request: .own(urlString: url))
//                }
//            }
//            for try await data in group {
//                images.append(Image(uiImage: UIImage(data: data)!))
//            }
//        }
//        var myView: any View {
//            ScrollView {
//                ForEach((0 ..< images.count), id: \.self) { index in
//                    ZStack {
//                        images[index]
//                            .resizable()
//                            .frame(width: 200.0, height: 200.0)
//                        Text("\(photos[index].id)")
//                    }
//                }
//            }
//        }
//        let diff = CFAbsoluteTimeGetCurrent() - start
//        print("Took \(diff) seconds")
//        DispatchQueue.main.async {
//            print("main")
//            PlaygroundPage.current.setLiveView(myView)
//        }
//    } catch {
//        print(error)
//    }
//}



// MARK: - withCheckedContinuation



//func fetchAsync() async throws -> [User] {
//    return try await withCheckedThrowingContinuation { continuation in
//        fetch(request: .users) { (result: Result<[User], Error>) in
//            continuation.resume(with: result)
////            switch result {
////            case .failure(let error): continuation.resume(throwing: error)
////            case .success(let users): continuation.resume(returning: users)
////            }
//
//            /*
//                U can't call resume twice or u will get a FATAL ERROR!
//            */
//        }
//    }
//}
//
//Task {
//    do {
//        print(try await fetchAsync())
//        print("")
//    } catch {
//        print(error)
//    }
//}



// MARK: - Saved Continuation



//var activeContinuation: CheckedContinuation<[User], Error>?
//
//func fetchAsync() async throws -> [User] {
//    return try await withCheckedThrowingContinuation { continuation in
//        activeContinuation = continuation
//    }
//}
//
//Task {
//    do {
//        print(try await fetchAsync())
//    } catch {
//        print(error)
//    }
//}
//
//fetch(request: .users) { (result: Result<[User], Error>) in
//    activeContinuation?.resume(with: result)
//}



// MARK: - AsyncSequence



/// `AsyncStream` conforms to `AsyncSequence`, providing a convenient way to
/// create an asynchronous sequence without manually implementing an
/// asynchronous iterator. In particular, an asynchronous stream is well-suited
/// to adapt callback- or delegation-based APIs to participate with
/// `async`-`await`.

//public class AsyncSequenceFactory {
//
//    func makeAsyncSequence() -> AsyncThrowingStream<Data, Error> {
//        return AsyncThrowingStream { continuation in
//            Task {
//                do {
//                    for url in photos.map(\.url) {
//                        let data: Data = try await fetchData(request: .own(urlString: url))
//                        continuation.yield(data)
//                    }
//                } catch {
////                    continuation.yield(with: .failure(error))
//                    continuation.finish(throwing: error)
//                }
//            }
//        }
//    }
//}
//
//Task {
//    do {
//        for try await data in AsyncSequenceFactory().makeAsyncSequence() {
//            print("Data \(data)\n")
//        }
//    } catch {
//        print(error)
//    }
//}



// MARK: - Thread Explosion



/*
 https://swiftsenpai.com/swift/swift-concurrency-prevent-thread-explosion/
*/



// MARK: - Actor



/*
 Data Race - https://miro.medium.com/v2/resize:fit:1400/format:webp/1*jdJfFuxkCoNbJ9v8rot8mQ.png
 Thread Sanitizer - https://miro.medium.com/v2/resize:fit:1400/format:webp/1*iuMRbUzO_mVdS2ZAaBnAxA.png
*/

//final class BankAccount {
//
//    private let IBAN = "AA12345678901234567890"
//
//    private(set) var balance = 0
//
//    func bankDetails() -> String { return IBAN }
//
//    func deposit() -> Int {
//        balance = balance + 100
//        return balance
//    }
//}
//
//let bankAccount = BankAccount()
//for _ in 1...1000 {
//    DispatchQueue.global().async {
//        print(bankAccount.deposit())
//    }
//
//    print(bankAccount.deposit())
//}

//actor BankAccount {
//
//    private let IBAN = "AA12345678901234567890"
//
//    private(set) var balance = 0
//
//    func bankDetails() -> String { return IBAN }
//
//    func deposit() -> Int {
//        balance = balance + 100
//        return balance
//    }
//}
//
//let bankAccount = BankAccount()
//for _ in 1...1000 {
//    DispatchQueue.global().async {
//        Task {
//            print(await bankAccount.deposit())
//        }
//    }
//
//    Task {
//        print(await bankAccount.deposit())
//    }
//}

//actor BankAccount {
//
//    private let IBAN = "AA12345678901234567890"
//
//    private(set) var balance: Double = 0
//
//    nonisolated func bankDetails() -> String { return IBAN }
//
//    func deposit() -> Double {
//        balance = balance + 100.0
//        return balance
//    }
//
//
//    /// "nonisolated" by default because it is immutable (let)
//    let someDataLet: String = "Some Data Let"
//    nonisolated var someDataVar: String { return "Some Data Var" }
//
//    func transfer(amount: Double, to someAccount: isolated SomeAccount) async {
//        someAccount.value += amount
//    }
//}
//
//actor SomeAccount {
//
//    var value: Double = 0
//}
//
//let bankAccount = BankAccount()
//print(bankAccount.bankDetails())
//print(bankAccount.someDataLet)
//print(bankAccount.someDataVar)
//
//let someAccount = SomeAccount()
//for _ in 1...1000 {
//    DispatchQueue.global().async {
//        Task {
//            await bankAccount.transfer(amount: 100, to: someAccount)
//        }
//    }
//
//    Task {
//        await bankAccount.transfer(amount: 100, to: someAccount)
//    }
//}
//Task {
//    try await Task.sleep(for: .seconds(3.0))
//    print(await someAccount.value)
//}

//@MainActor
//final class SomeClass {
//
//    func doSomething() {}
//}
//
//final class SomeNewClass {
//
//    @MainActor var array: [Int] = []
//
//    @MainActor
//    func append() {
//        array.append(1)
//    }
//
//    @MyActor
//    func someWork() {}
//}
//
//@globalActor
//actor MyActor {
//    static var shared = MyActor()
//}



// MARK: - SwiftUI + task



//struct MyView: View {
//
//    var body: some View {
//        Color.green
//            .frame(width: 200.0, height: 200.0)
//            .onAppear() {
//                Task {
//                    await printAsync(1)
//                }
//            }
//            .task {
//                await printAsync(2)
//            }
//    }
//
//    private func printAsync(_ value: Int = 0) async {
//        print("\(value) #function execution")
//    }
//}
//
//PlaygroundPage.current.setLiveView(MyView())



// MARK: - Models



enum Request {
    
    case users
    case photos
    case own(urlString: String)
    
    var url: URL? {
        switch self {
        case .users: return URL(string: Request.root + "users")
        case .photos: return URL(string: Request.root + "photos")
        case .own(let string): return URL(string: string)
        }
    }
    
    private static let root: String = "https://jsonplaceholder.typicode.com/"
}

struct User: Decodable, Identifiable {
    
    let id: Int
    let name: String
    let username: String
    let email: String
}

struct Photo: Decodable, Identifiable {
    
    let id: Int
    let title: String
    let url: String
}



// MARK: - RunLoop



RunLoop.main.run()
