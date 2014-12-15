import com.almondarts.chess.pieces { King }
import ceylon.collection { LinkedList }
shared abstract class AbstractBoard() satisfies Board {

	shared actual Board apply(Move move) {
		if (exists tp = move.targetPiece) {
			return createNext()
				.removeLocation(move.from)
				.removePiece(tp)
				.putPiece(move.piece, move.to);
		} else {
			return createNext()
				.removeLocation(move.from)
				.putPiece(move.piece, move.to);
		}
	}
	
	shared formal Board createNext();

	shared actual Board assume(Move move) {
		if (exists tp = move.targetPiece) {
			return createLookahead()
				.removeLocation(move.from)
				.removePiece(tp)
				.putPiece(move.piece, move.to);
		} else {
			return createLookahead()
				.removeLocation(move.from)
				.putPiece(move.piece, move.to);
		}
	}

	shared formal Board createLookahead();

	shared actual Boolean legalMove(Move move) {
		return assume(move).legalScenario(move.nextColor);
	}

	shared actual Boolean legalScenario(Color color) {
		for (piece->loc in getPiecesByColor(color)) {
			for (Move move in piece.possibleMoves(this, loc)) {
				if (move.targetPiece is King) {
					return false;
				}
			}
		}
		return true;
	}

	shared actual List<Piece->Location> getSortedPieces() {
		List<Piece->Location> sorted = LinkedList({for (piece->loc in getPieces()) piece->loc});
		return sorted.sort((Piece->Location entry1, Piece->Location entry2) => entry1.item.locationIndex.compare(entry2.item.locationIndex));
	}
	
	shared actual List<Move> possibleMoves(Color color) {
		return LinkedList();
	}
	
	shared actual List<Move> legalMoves(Color color) {
		return LinkedList();
	}
	
	shared actual List<Move> computePossibleStrikes(Color color) {
		return LinkedList();
	}
	
	shared actual List<Move> computeLegalStrikes(Color color) {
		return LinkedList();
	}
	
}