import UIKit
import RxSwift

var str = "Hello, playground"

enum ConversionError: Error {
    case errorOccurred
}

print("map/catchError/catchErrorJustReturn try....")
print()

func result() -> Observable<[Double]> {
    
    let array = [1, 2, 3]
    
    return Observable.just(array)
                .map { (array)  in
                        //return [1.0, 2.0, 3.0]
                        throw ConversionError.errorOccurred
                }
//                .catchError { (error) -> Observable<[Double]> in
//                    return Observable.just([4.0, 5.0])
//                }
                .catchErrorJustReturn([0.0])
}

result().subscribe { (array) in
    print(array)
} onError: { (error) in
    print(error)
} onCompleted: {
    print("completed")
} onDisposed: {
    print("disposed")
}

print()
print("Single try......")

func resultWithSingle() -> Single<[Double]> {
    
    var success = false
    
    let single = Single<[Double]>.create { single in
        if success {
            single(.success([1, 2, 3]))
        }
        else {
            single(.error(ConversionError.errorOccurred))
        }
        
        return Disposables.create{}
    }
    return single
}

resultWithSingle()
    .catchErrorJustReturn([0])
    .subscribe { (value) in
        print(value)
    } onError: { (error) in
        print(error)
    }

print()
print("Single try again......")

let single: Single<[Double]> = Single<[Double]>.just([])
single
    .subscribe { (value) in
        print(value)
    } onError: { (error) in
        print(error)
    }
