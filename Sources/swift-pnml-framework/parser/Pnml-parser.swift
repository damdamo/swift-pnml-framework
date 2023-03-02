import Foundation

class PnmlParser: NSObject, XMLParserDelegate {
  
  var net: [String: String] = [:]
  var places: [String: [String: String]] = [:]
  var transitions: [String: [String: String]] = [:]
  var arcs: [String: [String: String]] = [:]
  var currentID = ""
  var currentValue = ""
  var currentDic = [String: String]()
  let regularTags = Set<String>(["name", "initialmarking", "inscription"])
  //  let dictionaryKeys = Set<String>(["place", "transition", "arc"])


  func loadPN(filePath: String) {    
    if let url = Bundle.module.url(forResource: filePath, withExtension: nil) {
      let parser = XMLParser(contentsOf: url)!
      parser.delegate = self
      parser.parse()
    }
  }
  
  func loadPN(url: URL) /*-> PetriNet*/ {
    let parser = XMLParser(contentsOf: url)!
    parser.delegate = self
    parser.parse()
  }
  
  
  func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    switch elementName.lowercased() {
      case "net":
      if let id = attributeDict["id"] {
        net["id"] = id
      }
      if let type = attributeDict["type"] {
        net["type"] = type
      }
      case "place":
      if let id = attributeDict["id"] {
        currentID = id
        places[id] = [:]
      }
      case "transition":
      if let id = attributeDict["id"] {
        currentID = id
        transitions[id] = [:]
      }
      case "arc":
      if let id = attributeDict["id"] {
        currentID = id
        arcs[id] = [:]
        if let source = attributeDict["source"] {
          arcs[id]!["source"] = source
        }
        if let source = attributeDict["target"] {
          arcs[id]!["target"] = source
        }
      }
      default:
        break
      }
  }

  
  func parser(_ parser: XMLParser, foundCharacters string: String) {
    if !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
      currentValue = string
    }
  }

  
  func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    switch elementName.lowercased() {
    case "place":
      places[currentID] = currentDic
      currentDic = [:]
    case "transition":
      transitions[currentID] = currentDic
      currentDic = [:]
    default:
      if regularTags.contains(elementName) {
        currentDic[elementName] = currentValue
      }
    }
    
  }

  func parserDidEndDocument(_ parser: XMLParser) {
//    if elementName == "net" {
//      parsingCompleted()
//    } else if dictionaryKeys.contains(elementName) {
//
//    }
    print("net: \(net)")
    print("place: \(places)")
    print("transitions: \(transitions)")
    print("arcs: \(arcs)")
  }
  
//  func createPN() -> PetriNet {
//    
//    var petriNetPlaces: Set<Place> = []
//    var petriNetTransitions: Set<Transition> = []
//    var marking: [Place: Int] = [:]
//    var nameTemp: String = ""
//    var placeTemp: Place
//    
//    for (id, infoPlace) in places {
//      nameTemp = infoPlace["name"] ?? id
//      placeTemp = Place(name: nameTemp)
//      petriNetPlaces.insert(placeTemp)
//      marking[placeTemp] =  Int(infoPlace["initialmarking"] ?? "0")
//    }
//    
//    var inputs: [Transition: [Place: Int]] = [:]
//    var outputs: [Transition: [Place: Int]] = [:]
//    var idIn = ""
//    var idOut = ""
//    
//    for (id, infoArc) in arcs {
//      idIn = infoArc["source"]
//      idOut = infoArc["target"]
//      if let _ = places[idTemp] {
//        
//      } else {
//        
//      }
//    }
//    
//    return PetriNet(name: net["name"],
//                    places: places,
//                    transitions: transitions,
//                    inputs: inputs,
//                    outputs: outputs)
//  }
  
}
