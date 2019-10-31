public enum Edge {
	case start
	case end
}

extension Edge: CaseIterable, Customizable, ExpressibleByInt, Randomable { }
