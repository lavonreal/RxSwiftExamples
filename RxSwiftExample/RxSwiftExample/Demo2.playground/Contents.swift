import UIKit
import RxSwift

var intObservable: Observable<Int> = Observable.from([1, 2, 3])
var stringObservable = intObservable.map { "value is \($0)"} // map here returns another Observable
stringObservable.subscribe(onNext: { value in print(value)})

print()
print("flatmap trying")

var observableOfObservables: Observable<Observable<Int>> = Observable.just(intObservable)


observableOfObservables.subscribe(onNext: { value in print(value)})

observableOfObservables.map({ return $0}).subscribe(onNext: { value in print(value)})

observableOfObservables.flatMap({ return $0 }).subscribe(onNext: { value in print(value)})


print()
print("combine latest with publish subject")

let pubSubject1 = PublishSubject<String>()
let pubSubject2 = PublishSubject<String>()

pubSubject1.onNext("one")
pubSubject2.onNext("2")

Observable
    .combineLatest(pubSubject1, pubSubject2)
    .subscribe { (value1, value2) in
        print(value1)
        print(value2)
    }

pubSubject2.onNext("two")
pubSubject1.onNext("one again")

pubSubject2.onNext("three")

pubSubject1.onNext("try new")



print()
print("combine latest with behavior subject")

let behaviorSubject1 = BehaviorSubject<String>(value: "one")
let behaviorSubject2 = BehaviorSubject<String>(value: "two")

Observable
    .combineLatest(behaviorSubject1, behaviorSubject2)
    .subscribe { (value1, value2) in
        print("behaviorsubject1 value1 \(value1)")
        print("behaviorsubject2 value2 \(value2)")
    }

behaviorSubject1.onNext("three")
behaviorSubject2.onNext("four")
