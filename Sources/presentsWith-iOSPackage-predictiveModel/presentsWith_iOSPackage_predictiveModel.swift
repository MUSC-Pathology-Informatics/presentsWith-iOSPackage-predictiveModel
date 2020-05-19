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
    
    /* {"timestamp":"2020-05-19 07:57:48","sample_type":"statusPost.healthKit.collector","sample_sub_type":"stepCount","sample_id":"BC5AB3F3-9EC7-46CC-8C9D-2261843BD717","study_id":"(null)-20200306103206492","participant_id":"02cf7f733106c581a9e4d9cffd3e3ec5","study_participant_id":"ACBFD117-70CB-4A86-AB9D-48853927DF69","event_name":"healthkit_collecto_arm_1","field_name":"collector_step_count","value_int":11}
 
    */
    
    public var participant_data = [NSDictionary]()
    
    public var model_json = ""
    
    private var result = ""
    
    

    
    public func getFormattedResult() -> String? {
        
        //result = participant_data + " " + model_json
        
        result = "hey now from the package: " + String(participant_data.count)

        var steps = [NSDictionary]()
        
        var heart_rate = [NSDictionary]()
        
        steps = participant_data.filter({ ($0["field_name"] as? String) == "collector_step_count" })
        
        heart_rate = participant_data.filter({ ($0["field_name"] as? String) == "collector_heart_rate" })
        
        
        
        
        //for dict in heart_rate {
            //print(dict)
            
                //print("here is a heart rate")
            
        //}
        
        
        let data = model_json.data(using: .utf8)!
        
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
            {
               //print(jsonArray) // use the json here
                
                let the_dict = jsonArray[0]
                
                let results_array = the_dict["results"] as! [NSDictionary]
                
                
                for result in results_array {
                    
                    let domain_array = result["domains"] as! [NSDictionary]
                    
                    for domain in domain_array {

                        let component_array = domain["components"] as! [NSDictionary]
                        
                        for component in component_array {
                            
                            //print(component)
                            //model stuff goes in here
                            
                            if let component_name = component["name"] {
                                //print(component_name)
                            }
                            
                            if let component_field = component["field"] as? String {
                                //print(component_field)
                                
                                var the_data_array = [NSDictionary]()
                                
                                the_data_array = participant_data.filter({($0["field_name"] as? String) == component_field })
                                
                                print(the_data_array)
                                
                                var converted_data_array = NSMutableArray()
                                                   
                                
                                for sample in the_data_array {
                                    var date_time_string = sample["timestamp"] as! String
                                    
                                    
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                    
                                    let date = dateFormatter.date(from:date_time_string)!
                                    
                                    //let converted_sample = NSDictionary()
                                   // converted_sample.setValue(sample.even, forKey: <#T##String#>)
                                    //sample.setValue(date, forKey: "timestamp")
                                    
                                    var converted_sample = NSMutableDictionary()
                                    
                                    converted_sample.setValue(date, forKey: "timestamp2")
                                    converted_sample.setValue(sample["event_name"], forKey: "event_name")
                                    
                                    converted_data_array.add(converted_sample)
                                    print(converted_data_array.count)
                                    
                                }
                                
                                let sortedArray = converted_data_array.sorted {$0["timestamp2"]! < $1["timestamp2"]!}
                                
                                for sample in converted_data_array {
                                    print(sample)
                                }
                                
                                
                                
                                
                      
                            }
                            
                            
                            
                            if let component_model = component["model"] {
                                print(component_model)
                                
                            }
                            
                            
                            
                        }
                        
                        
                    }
                    
                    
                    
                }

                
                //var vector = results_array[0]
                
                
                
                //print "vector coming\n"
                
                //print vector
                
                
                
                
                
                
                
            } else {
                print("bad json")
            }
        } catch let error as NSError {
            print(error)
        }
       
        
        
        
        
        return result
    }
    
    

}



