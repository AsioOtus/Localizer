public func debug (_ block: () -> ()) {
	#if DEBUG
	block()
	#endif
}
