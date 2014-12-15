import com.almondarts.chess { Board, Piece, Location, Move }
import ceylon.collection { MutableList, LinkedList }
shared abstract class MovesBuilder(board, piece, location) {

	Board board;
	Location location;
	Piece piece;
	shared MutableList<Move> moves = LinkedList<Move>();
	shared List<Move> list => moves;

	shared MovesBuilder proposeMoveOrStrike(Location proposed) {
		if (proposed == location) {
			return this;
		}
		if (exists targetPiece = board.getPiece(proposed)) {
			if (targetPiece.opponent(piece)) {
				proposeStrike(proposed, targetPiece);
			}
		} else {
			proposeMove(proposed);
		}
		return this;
	}

	shared MovesBuilder proposeMoveOrStrikeBreakingOnFirstObstacle(List<Location> proposeds) {
		for (Location proposed in proposeds) {
			if (exists targetPiece = board.getPiece(proposed)) {
				if (piece.opponent(targetPiece)) {
					proposeStrike(proposed, targetPiece);
				}
				break; // break at first obstacle
			} else {
				proposeMove(proposed);
			} 
		}
		return this;
	}
	
	shared void proposeMove(Location proposed) {
		if (proposed == location) {
			return;
		} else if (board.getPiece(proposed) exists) {
			return;
		}
		propose(Move(piece, location, proposed));
	}

	shared void proposeStrike(Location proposed, Piece targetPiece) {
		if (proposed == location) {
			return;
		}
		assert(board.getPiece(proposed)?.equals(targetPiece) else true);  
		propose(Move(piece, location, proposed, targetPiece));
	}

	shared formal void propose(Move move);
	
}