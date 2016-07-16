//
//  Docs.swift
//  nodejs
//
//  Created by D_ttang on 15/1/4.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import Foundation

class Docs {
    
    class IndexDoc {
        var type: String?
        var text: String?
        var jsonPre: String?
        
        class func createFromJSON(json: JSONValue) -> IndexDoc {
            let indexDoc = IndexDoc()
            if let type = json["type"]?.string {
                indexDoc.type = type
            }
            if let text = json["text"]?.string {
                var tmpArr = text.componentsSeparatedByCharactersInSet(NSCharacterSet (charactersInString: "[]()."))
                indexDoc.text = tmpArr[1]
                indexDoc.jsonPre = tmpArr[3]
            }
            return indexDoc
        }
    }
    
    
    class ModuleDoc {
        
        var textRaw:String? = "Buffer"
        var name:String? = "buffer"
        var stability:Int = 3
        var stabilityText:String? = "Stable"
        var desc = ""
        
        class func createFromJSON(json: JSONValue) -> ModuleDoc {
            let moduleDoc = ModuleDoc()
            let module = json["modules"]?[0]
            if let textRaw = module?["textRaw"]?.string {
                moduleDoc.textRaw = textRaw
            }
            if let name = module?["name"]?.string {
                moduleDoc.name = name
            }
            return moduleDoc
        }
    }
}
