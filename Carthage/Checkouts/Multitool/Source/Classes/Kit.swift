public class Kit<Item> {
	private var items = [Item]()

	public var clone: Kit {
		return Kit(items)
	}

	public required init () { }

	public init (_ item: Item) {
		items.append(item)
	}

	public init (_ items: [Item]) {
		self.items.append(contentsOf: items)
	}

	public init (_ kit: Kit) {
		self.items.append(contentsOf: kit.items)
	}
}

public extension Kit {
	public func add (_ item: Item, at edge: Edge = .end) {
		if edge == .end {
			items.append(item)
		} else {
			items.insert(item, at: 0)
		}
	}

	public func add (_ items: [Item], at edge: Edge = .end) {
		if edge == .end {
			self.items.append(contentsOf: items)
		} else {
			self.items.insert(contentsOf: items, at: 0)
		}
	}

	func insert (_ item: Item, at position: Int = 0) {
		items.insert(item, at: position)
	}

	func insert (_ items: [Item], at position: Int = 0) {
		self.items.insert(contentsOf: items, at: position)
	}
}

public extension Kit {
	public func take (at position: Int) -> Item? {
		guard position >= 0 && position < items.count else { return nil }

		let foundedItem = items[position]
		delete(at: position)
		return foundedItem
	}

	public func take (range: Range<Int>) -> [Item] {
		let foundedItems = items[range]
		delete(range: range)
		return [Item](foundedItems)
	}

	public func takeAll () -> [Item] {
		let items = self.items
		clear()
		return items
	}
}

public extension Kit {
	public func giveAll (to kit: Kit) {
		kit.add(kit.items)
		clear()
	}
}

public extension Kit {
	public func delete (at position: Int) {
		items.remove(at: position)
	}

	public func delete (range: Range<Int>) {
		items.removeSubrange(range)
	}

	public func clear () {
		items.removeAll(keepingCapacity: false)
	}
}

extension Kit: Customizable, ClosureInitializable { }
