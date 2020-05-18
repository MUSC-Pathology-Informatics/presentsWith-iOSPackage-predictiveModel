import Foundation

/*
public struct presentsWith_iOSPackage_predictiveModel {
    public var text = "Hello, World!"
}
*/


public class PredictiveModelPackage {
    
    // MARK: - Init
    
    public init() {
        
    }
    

    
    //MARK: - Model
    
    public var participant_data = ""
    
    public var model_json = ""
    
    private var result = ""
    
    public func getFormattedResult() -> String? {
        
        result = participant_data + " " + model_json
        
        return result
    }
    
    

}



