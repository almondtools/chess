import ceylon.collection { HashMap, MutableMap,
	Hashtable,
	linked }

shared class LookAheadBoard(base, size) extends AbstractBoard() satisfies Board {
		
	ConcreteBoard base;
	Integer size;
	MutableMap<Piece, Location> added = HashMap<Piece, Location>();  
	MutableMap<Piece, Location> removed = HashMap<Piece, Location>();  

	shared LookAheadBoard clone {
		return LookAheadBoard(base, size);
	}

	shared actual Board createNext() {
		Board next = base.createNext();
		for (piece->location in removed) {
			next.removePiece(piece);
		}
		for (piece->location in added) {
			next.putPiece(piece, location);
		}
		return next;
	}
	
	shared actual Board createLookahead() {
		LookAheadBoard board = LookAheadBoard(base, ((removed.size > added.size) then removed.size else added.size) + 1);
		board.added.putAll(added);
		board.removed.putAll(removed);
		return board;
	}

	shared actual Board putPiece(Piece piece, Location location) {
		if (exists basepiece = base.getPiece(location)) {
			removed.remove(basepiece);
			if (piece == basepiece) {
				added.remove(piece);
			} else {
				added.put(piece, location);
			}
		} else {
			added.put(piece, location);
		}
		return this;
	}

	shared actual Board removePiece(Piece piece) {
		added.remove(piece);
		for (basepiece->location in base.getPiecesByColor(piece.color)) {
			if (basepiece == piece) {
				removed.put(piece, location);
			}
		}
		return this;
	}

	shared actual Board removeLocation(Location location) {
		if (exists basepiece = base.getPiece(location)) {
			removed.put(basepiece, location);
		} else {
			added.find((Piece->Location entry) => entry.item == location);
		}
		return this;
	}

	shared actual Piece? getPiece(Location location) {
		for (piece->loc in added) {
			if (loc == location) {
				return piece;
			}
		}
		for (piece->loc in removed) {
			if (loc == location) {
				return null;
			}
		}
		return base.getPiece(location);
	}

	shared actual Map<Piece, Location> getPieces() {
		MutableMap<Piece, Location> entries = HashMap<Piece, Location>(linked, Hashtable(), base.getPieces());
		for (piece->loc in removed) {
			entries.remove(piece);
		}
		for (piece->loc in added) {
			added.put(piece, loc);
		}
		return entries;
	}

	shared actual Map<Piece,Location> getPiecesByColor(Color criteria) {
		MutableMap<Piece, Location> entries = HashMap<Piece, Location>(linked, Hashtable(), base.getPieces());
		for (piece->loc in removed ) {
			if (piece.color == criteria) {
				entries.remove(piece);
			}
		}
		for (piece->loc in added) {
			if (piece.color == criteria) {
				added.put(piece, loc);
			}
		}
		return entries;
	}

}