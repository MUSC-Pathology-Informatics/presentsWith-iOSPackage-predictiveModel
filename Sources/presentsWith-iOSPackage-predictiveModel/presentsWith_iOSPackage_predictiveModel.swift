import Foundation


struct presentsWith_iOSPackage_predictiveModel {
    var text = "Hello, World!"
}


class A {
    struct StructOfClassA {
        func returnLetterA() -> String{
            return "a"
        }
    }

    var structOfClassA = StructOfClassA()
        /* Instance of 'StructOfClassA' structure type */
}

class B {
    let classA = A()

    init() {
        let myLetter = classA.structOfClassA.returnLetterA()
        print(myLetter)
    }
}

var myB = B() // prints "a"



/*

let ParseApplicationId = "xxx"
let ParseClientKey = "xxx"
let AppGreenColor = UIColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 1.0)

@objc class Constant: NSObject {
    override private init() {}

    class func parseApplicationId() -> String { return ParseApplicationId }
    class func parseClientKey() -> String { return ParseClientKey }
    class func appGreenColor() -> UIColor { return AppGreenColor }
}

 */
