import UIKit
import RxSwift

var str = "Hello, playground"

// Observable is one to one
// One Observable to one observer
var intObservable = Observable.from([2, 2, 3])

intObservable
    .subscribe { (value) in
        print("sub1 \(value)")
    } onError: { (error) in
        print(error)
    } onCompleted: {
        print("completed")
    } onDisposed: {
        print("disposed")
    }


intObservable
    .subscribe { (value) in
        print("sub2 \(value)")
    } onError: { (error) in
        print(error)
    } onCompleted: {
        print("completed")
    } onDisposed: {
        print("disposed")
    }


// Subjects are multicast
// One Subject with many subscribers, depends on the Subject type the value to the
// observer is sent

print()
print("****** pubSubject *******")

let pubSubject = PublishSubject<String>()

pubSubject.onNext("one")

pubSubject.subscribe { (event) in
    switch event {
    case .next(let value):
        print("pubsubscriber1 \(value)")
    default:
        print("Default")
    }
}

pubSubject.subscribe { (event) in
    switch event {
    case .next(let value):
        print("pubsubscriber2 \(value)")
    default:
        print("Default")
    }
}

pubSubject.onNext("two")

pubSubject.subscribe { (event) in
    switch event {
    case .next(let value):
        print("pubsubscriber3 \(value)")
    default:
        print("Default")
    }
}


print()
print("****** behaviorSubject *******")

let behaviorSubject = BehaviorSubject<String>(value: "zero")

behaviorSubject.subscribe { (event) in
    switch event {
    case .next(let value):
        print("pubsubscriber1 \(value)")
    default:
        print("Default")
    }
}

behaviorSubject.subscribe { (event) in
    switch event {
    case .next(let value):
        print("pubsubscriber2 \(value)")
    default:
        print("Default")
    }
}

behaviorSubject.onNext("one")

behaviorSubject.onNext("two")

behaviorSubject.subscribe { (event) in
    switch event {
    case .next(let value):
        print("pubsubscriber3 \(value)")
    default:
        print("Default")
    }
}

behaviorSubject.onNext("three")
