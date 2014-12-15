import ceylon.collection { HashMap, MutableMap}
import com.almondarts.chess { location, a, white, Piece, Board, Location, AbstractBoard, black, h, Color }


shared class ConcreteBoard(Map<Location, Piece> locations = emptyMap) extends AbstractBoard() satisfies Board {
		
	Array<Array<Piece?>> board = Array({for (col in a..h) Array({for (row in 0..7) locations.get(internal(col, row))})});
	MutableMap<Piece, Location> whitepieces = HashMap<Piece, Location>{for (loc->piece in locations) if (piece.color == white) piece->loc};
	MutableMap<Piece, Location> blackpieces = HashMap<Piece, Location>{for (loc->piece in locations) if (piece.color == black) piece->loc};
	MutableMap<Piece, Location> pieces(Color color) {
		switch(color) 
		case(white) {
			return whitepieces;
		} 
		case (black) {
			return blackpieces;
		}  
	}

	shared ConcreteBoard clone {
		return ConcreteBoard(HashMap{for (col in a..h) for (row in 0..7) if (exists piece = board.get(col)?.get(row)) location(col, row) -> piece});
	}

	shared actual Board createNext() {
		return clone;
	}
	
	shared actual Board createLookahead() {
		return LookAheadBoard(this, 1);
	}

	shared actual Board putPiece(Piece piece, Location location) {
		Piece? oldpiece = board.get(location.colIndex)?.get(location.rowIndex);
		board.get(location.colIndex)?.set(location.rowIndex, piece);
		if (exists oldpiece) {
			pieces(oldpiece.color).remove(oldpiece);
		}
		pieces(piece.color).put(piece, location);
		return this;
	}

	shared actual Board removePiece(Piece piece) {
		if (exists location = pieces(piece.color).remove(piece)) {
			board.get(location.colIndex)?.set(location.rowIndex, null);
		}
		return this;
	}

	shared actual Board removeLocation(Location location) {
		if (exists piece = board.get(location.colIndex)?.get(location.rowIndex)) {
			board.get(location.colIndex)?.set(location.rowIndex, null);
			pieces(piece.color).remove(piece);
		}
		return this;
	}

	shared actual Piece? getPiece(Location location) {
		return board.get(location.colIndex)?.get(location.rowIndex);
	}

	shared actual Map<Piece,Location> getPieces() {
		MutableMap<Piece,Location> allPieces = HashMap<Piece, Location>();
		allPieces.putAll(whitepieces);
		allPieces.putAll(blackpieces);
		return allPieces;
	}

	shared actual Map<Piece,Location> getPiecesByColor(Color criteria) {
		return pieces(criteria);
	}

}