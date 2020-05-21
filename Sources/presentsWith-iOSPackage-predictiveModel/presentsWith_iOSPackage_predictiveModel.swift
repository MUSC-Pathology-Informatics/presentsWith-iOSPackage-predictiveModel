import Foundation


struct Sample {
    
    var timestamp:Date
    var sample_type:String
    var sample_sub_type:String?
    var sample_id:String?
    var study_id:String
    var participant_id:String
    var study_participant_id:String
    var event_name:String
    var field_name:String
    var value_int: Int?
    var value_float: Double?
    
    init(timestamp: Date,sample_type: String, sample_sub_type:String?, sample_id:String?, study_id:String, participant_id:String, study_participant_id:String, event_name:String, field_name:String, value_int:Int?, value_float:Double?) {
        self.timestamp = timestamp
        self.sample_type = sample_type
        self.sample_sub_type = sample_sub_type
        self.sample_id = sample_id
        self.study_id = study_id
        self.participant_id = participant_id
        self.study_participant_id = study_participant_id
        self.event_name = event_name
        self.field_name = field_name
        self.value_int = value_int
        self.value_float = value_float
        
        
    }
}



public class PredictiveModelPackage {
        
    public var participant_data:[NSDictionary]
    
    public var model_json:String
    
    var participant_samples:[Sample]?
    
    
    public init(participant_data:[NSDictionary],model_json:String) {
        
        self.participant_data = participant_data
        self.model_json = model_json
        
        var participant_samples = self.createSamples(participant_date: participant_data)

        //reverse order
        participant_samples.sort { (lhs: Sample, rhs: Sample) -> Bool in
            // you can have additional code here
            return lhs.timestamp > rhs.timestamp
        }
        
        self.participant_samples = participant_samples

    }
    

    

    
    public func getFormattedResult() -> String? {
        
        let model_json_data_string = model_json.data(using: .utf8)!
        
        let result = "hey now from the package: " + String(participant_data.count)
    
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: model_json_data_string, options : .allowFragments) as? [Dictionary<String,Any>]
            {
               //print(jsonArray) // use the json here
                
                let the_dict = jsonArray[0] //single item array - the item is all of out data
                
                let results_array = the_dict["results"] as! [NSDictionary] // top level
                
                for result in results_array {
                    
                    let domain_array = result["domains"] as! [NSDictionary]
                    
                    for domain in domain_array {

                        let component_array = domain["components"] as! [NSDictionary]
                        
                        for component in component_array {
                            
                            var component_data:[Sample]?
                            
                            if let component_name = component["name"] {
                                //print(component_name)
                            }
                            
                            
                            if let component_sample_sub_type = component["sample_sub_type"] as? String {
                                
                                //print(component_sample_sub_type)
                                
                                component_data = dump(self.participant_samples!.filter({$0.sample_sub_type == component_sample_sub_type}))
                                
                                //for sample in component_data! {
                                    //print(sample)
                                //}
                            }
                            
                            
                            if let component_field = component["field"] as? String {
                                
                                print(component_field)
                                
                                component_data = dump(self.participant_samples!.filter({$0.sample_sub_type == component_field}))
                                
                            }
                            
                            
                            
                            if let component_models = component["models"] as? [NSDictionary] {
                                
                                for component_model in component_models {
                                    //print(component_model)
                                                                   
                                    var group_count:Int?
                                    var group_duration:String?
                                    var group_frequency:String?
                                    var requirements_array:[String]?
                                       
                                    if let model_group_count = component_model["group_count"] as? Int { group_count = model_group_count }
                                    
                                    if let model_group_duration = component_model["group_duration"] as? String { group_duration = model_group_duration }
                                    
                                    if let model_group_frequency = component_model["group_frequency"] as? String { group_frequency = model_group_frequency }
                                    
                                    if let model_requirements_array = component_model["requirements"] as? [String] {
                                        requirements_array = model_requirements_array
                                        
                                    }
                                    
                                    print(requirements_array)
                                    
                                    
                                    //print(group_count)
                                    //print(group_duration)
                                    //print(group_frequency)
                                    
                                    
                                    // NOW EXECUTE THE MODEL
                                    
                                    if let model_data = component_data {
                                        
                                        for i in 0..<group_count! {
                                            // Do stuff...
                                            print("get a groups of samples!" + String(i))
                                            
                                            let startDate = Calendar.current.date(byAdding: .day,value: -i - 1,to: Date())
                                            let endDate = Calendar.current.date(byAdding: .day,value: -i,to: Date())
                                            print(startDate)
                                            print(endDate)
                                            
                                            
                                            let group_data_remove_end:[Sample] = dump(model_data.filter({$0.timestamp < endDate!}))
                                            let group_data:[Sample] = dump(group_data_remove_end.filter({$0.timestamp > startDate!}))
                                            
                                            for sample in group_data {
                                                print(sample)
                                                
                                                if requirements_array != nil {
                                                    for requirement in requirements_array! {
                                                    
                                                        if let value_float = sample.value_float {
                                                            print(value_float)
                                                            
                                                            print(requirement)
                                                            
                                                            let requirement_string_array = requirement.components(separatedBy: " ")
                                                            
                                                            
                                                            
                                                            //var logicalExpression = "sample.value_float > 101"
                                                            
                                                            //print(logicalExpression)
                                                            
                                                            //let predicate = NSPredicate(format: logicalExpression)
                                                            var result = predicate.evaluate(with: "") as Bool
                                                            
                                                            if (result) {
                                                                print(" i should get a transform!")
                                                            } else {
                                                                print(" no transform!")
                                                            }
                                                            
                                                            
                                                            
                                                        }
                                                    }
                                                }
                                                
                                            }
                                            

                                        }
                                        
                                    }
                                    
                                    
                                    
                          
                                }
                                
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
    
    
    
    
    
    
    func createSamples(participant_date:[NSDictionary]) ->[Sample] {
        
        var converted_participant_data = [Sample]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        
        for sample in participant_data {
            
            //print(sample)
        
            if let timestamp_string = sample["timestamp"] as? String {
  
                let sample_type = sample["sample_type"] as! String
                let study_id = sample["study_id"] as! String
                let participant_id = sample["participant_id"] as! String
                let study_participant_id = sample["study_participant_id"] as! String
                let event_name = sample["event_name"] as! String
                let field_name = sample["field_name"] as! String
                
                
                
                if sample_type == "survey" {
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                } else {
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                }
                
                let timestamp:Date? = dateFormatter.date(from:timestamp_string)
        
                var sample_sub_type:String?
                if let my_sample_sub_type = sample["sample_sub_type"] as? String {
                    sample_sub_type = my_sample_sub_type
                }
                
                var sample_id:String?
                if let my_sample_id = sample["sample_id"] as? String {
                    sample_id = my_sample_id
                }
                
                var value_int:Int?
                if let my_value_int = sample["value_int"] as? Int {
                    value_int = my_value_int
                }
                
                var value_float:Double?
                if let my_value_float = sample["value_float"] as? Double {
                    value_float = my_value_float
                }
                
                
                let new_sample = Sample(timestamp: timestamp!,sample_type: sample_type, sample_sub_type: sample_sub_type, sample_id: sample_id, study_id: study_id, participant_id: participant_id, study_participant_id: study_participant_id, event_name: event_name, field_name: field_name, value_int: value_int, value_float: value_float)

                converted_participant_data.append(new_sample)
            }
            
            
        }
        
        return converted_participant_data

    }

}



