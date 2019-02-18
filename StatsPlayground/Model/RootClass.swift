//
//  RootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on December 10, 2018

import Foundation


class RootClass : NSObject, NSCoding{

    var countries : [Country]!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        countries = [Country]()
        if let countriesArray = dictionary["countries"] as? [[String:Any]]{
            for dic in countriesArray{
                let value = Country(fromDictionary: dic)
                countries.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if countries != nil{
            var dictionaryElements = [[String:Any]]()
            for countriesElement in countries {
                dictionaryElements.append(countriesElement.toDictionary())
            }
            dictionary["countries"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        countries = aDecoder.decodeObject(forKey: "countries") as? [Country]
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if countries != nil{
            aCoder.encode(countries, forKey: "countries")
        }
    }
}