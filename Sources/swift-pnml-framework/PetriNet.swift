struct PetriNet {
  
  typealias Marking = [Place: Int]
  
  let name: String
  let places: Set<Place>
  let transitions: Set<Transition>
  let inputs: [Transition: [Place: Int]]
  let outputs: [Transition: [Place: Int]]
  let initialMarking: Marking = [:]
  
}

struct Place: Hashable {
  let name: String
}

struct Transition: Hashable {
  let name: String
}


extension PetriNet: CustomStringConvertible {
  public var description: String {
    return """
    Places: \(places)
    Transitions: \(transitions)
    Inputs: \(inputs)
    Outputs: \(outputs)
    """
  }
}

