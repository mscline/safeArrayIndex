
// CHECK FOR SAFE INDEX
//
// if let index = array.checkIndexForSafety(index:Int) {
//
//    let item = array[safeIndex: index]
//
// 
// if let index = array.checkIndexForSafety(index:Int) {
//
//    array[safeIndex: safeIndex] = myObject
//

// NOTES:
// No implementation required.  Just cut and paste this extension into your code.
// Many programmers I know, would not care to see the parameter name.  Thus, it is also possible to just call array[safeIndex]. The disadvantage of this approach is that you could accidentally call array[Int] instead of array[SafeIndex].
// You should never have to initialize your own SafeIndex object.  It is simply used to pass information from the checkIndexForSafety method to the array[safeIndex:index] call.

extension Array {

    @warn_unused_result public func checkIndexForSafety(index: Int) -> SafeIndex? {

        if indices.contains(index) {

            // wrap index number in object, so can ensure type safety
            return SafeIndex(indexNumber: index)

        } else {
            return nil
        }
    }

    subscript(index:SafeIndex) -> Element {

        get {
            return self[index.indexNumber]
        }

        set {
            self[index.indexNumber] = newValue
        }
    }

    // second version of same subscript, but with different method signature, allowing user to highlight using safe index
    subscript(safeIndex index:SafeIndex) -> Element {

        get {
            return self[index.indexNumber]
        }

        set {
            self[index.indexNumber] = newValue
        }
    }

}

public class SafeIndex {

    var indexNumber:Int

    init(indexNumber:Int){
        self.indexNumber = indexNumber
    }
}


// There are a number of different possible implementatations, so why did I choose this one?
// - Because arrays may store nil values, it does not make sense to return a nil if an array[index] call is out of bounds.
// - Because we do not know how a user would like to handle out of bounds problems, it does not make sense to use custom operators.
// - In contrast, by wrapping our index in a custom safeIndex object, we may use traditional control flow for unwrapping objects and ensure type safety.

