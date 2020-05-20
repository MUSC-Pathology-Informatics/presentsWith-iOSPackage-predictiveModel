import Foundation


struct Sample {
    
    var timestamp:Date
    var sample_type:String
    var sample_sub_type:String
    var sample_id:String
    var study_id:String
    var participant_id:String
    var study_participant_id:String
    var event_name:String
    var field_name:String
    var value_int: integer_t?
    var value_float: float_t?
    
    init(timestamp:Date,sample_type: String, sample_sub_type: String, sample_id:String, study_id:String, participant_id:String, study_participant_id:String, event_name:String, field_name:String) {
        self.timestamp = timestamp
        self.sample_type = sample_type
        self.sample_sub_type = sample_sub_type
        self.sample_id = sample_id
        self.study_id = study_id
        self.participant_id = participant_id
        self.study_participant_id = study_participant_id
        self.event_name = event_name
        self.field_name = field_name
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
        
        for sample in participant_samples {
            print(sample)
        }
    }
    

    

    
    public func getFormattedResult() -> String? {
        
        //result = participant_data + " " + model_json
        
        let data = model_json.data(using: .utf8)!
        
        
        
        
        
        
        
        
        
        
        let result = "hey now from the package: " + String(participant_data.count)
        
        /*
        var steps = [NSDictionary]()
        
        var heart_rate = [NSDictionary]()
        
        steps = participant_data.filter({ ($0["field_name"] as? String) == "collector_step_count" })
        
        heart_rate = participant_data.filter({ ($0["field_name"] as? String) == "collector_heart_rate" })
    
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
 
        */
       
        return result
    }
    
    
    
    
    
    
    func createSamples(participant_date:[NSDictionary]) ->[Sample] {
        
        var converted_participant_data = [Sample]()
        
        for sample in participant_data {

            print(sample)
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
            let timestamp_string = sample["timestamp"] as! String
            let timestamp = dateFormatter.date(from:timestamp_string)!
            let sample_type = sample["sample_type"] as! String
            let sample_sub_type = sample["sample_sub_type"] as! String
            let sample_id = sample["sample_id"] as! String
            let study_id = sample["study_id"] as! String
            let participant_id = sample["participant_id"] as! String
            let study_participant_id = sample["study_participant_id"] as! String
            let event_name = sample["event_name"] as! String
            let field_name = sample["field_name"] as! String
            
            
            let new_sample = Sample(timestamp:timestamp,sample_type: sample_type, sample_sub_type: sample_sub_type, sample_id: sample_id, study_id: study_id, participant_id: participant_id, study_participant_id: study_participant_id, event_name: event_name, field_name: field_name)

            converted_participant_data.append(new_sample)
            
        }
        
        return converted_participant_data

    }

}



