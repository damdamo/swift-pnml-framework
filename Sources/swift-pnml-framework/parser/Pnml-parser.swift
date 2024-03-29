import Foundation

class PnmlParser: NSObject, XMLParserDelegate {
  
  var net: [String: String] = [:]
  var places: [String: [String: String]] = [:]
  var transitions: [String: [String: String]] = [:]
  var arcs: [String: [String: String]] = [:]
  var currentID = ""
  var currentType = ""
  var currentTag = ""
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
        currentType = "net"
      }
      if let type = attributeDict["type"] {
        net["type"] = type
        currentType = "net"
      }
      case "place":
      if let id = attributeDict["id"] {
        places[id] = [:]
        currentID = id
        currentType = "place"
      }
      case "transition":
      if let id = attributeDict["id"] {
        transitions[id] = [:]
        currentID = id
        currentType = "transition"
      }
      case "arc":
      if let id = attributeDict["id"] {
        arcs[id] = [:]
        if let source = attributeDict["source"], let target = attributeDict["target"] {
          arcs[id]!["source"] = source
          arcs[id]!["target"] = target
          arcs[id]!["inscription"] = "1"
        }
        currentID = id
        currentType = "arc"
      }
      case "name":
        currentTag = "name"
      case "initialmarking":
        currentTag = "initialmarking"
      case "inscription":
        currentTag = "inscription"
      default:
        break
      }
  }

  
  func parser(_ parser: XMLParser, foundCharacters string: String) {
    if !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
      switch currentType {
      case "place":
        if regularTags.contains(currentTag) {
          places[currentID]![currentTag] = string
          currentTag = ""
        }
      case "transition":
        if regularTags.contains(currentTag) {
          transitions[currentID]![currentTag] = string
          currentTag = ""
        }
      case "arc":
        if regularTags.contains(currentTag) {
          arcs[currentID]![currentTag] = string
          currentTag = ""
        }
      default:
        break
      }
    }
  }

  func parserDidEndDocument(_ parser: XMLParser) {
    print("Parsing complete")
//    print("net: \(net)")
//    print("place: \(places)")
//    print("transitions: \(transitions)")
//    print("arcs: \(arcs)")
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
