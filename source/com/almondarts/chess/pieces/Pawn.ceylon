import com.almondarts.chess {
	Game,
	Piece,
	Color,
	Location,
	Board,
	Move, PieceVisitor
}
import com.almondarts.chess.pieces { AbstractPiece, PossibleMovesBuilder, LegalMovesBuilder, MovesBuilder }

shared abstract class Pawn(Game game, Color color) of WhitePawn | BlackPawn extends AbstractPiece(game, color) satisfies Piece {

	shared actual String name = "pawn";
	shared actual Character[] symbols = ['\{#2659}','\{#265F}'];

	shared Integer direction = color.direction;
	shared formal Integer startRow;
	shared formal Integer enPassantRow;
	

	shared actual List<Move> possibleMoves(Board board, Location location) {
		return computeMoves(PossibleMovesBuilder(board, this, location), board, location);
	}

	shared actual List<Move> legalMoves(Board board, Location location) {
		return computeMoves(LegalMovesBuilder(board, this, location), board, location);
	}

	List<Move> computeMoves(MovesBuilder moves, Board board, Location location) {
		if (exists loc = location.relative(0, direction)) {
			moves.proposeMove(loc);
		}
		
		for (loc in [location.relative(1, direction), location.relative(-1, direction)]) {
			if (exists loc) {
				if (exists targetPiece = board.getPiece(loc)) {
					moves.proposeStrike(loc, targetPiece);
				}
			}
		}
		
		if (location.row == startRow && !doubleMoveBlocked(board, location)) {
			if (exists loc = location.relative(0, 2 * direction)) {
				moves.proposeMove(loc);
			}
		}
		
		if (location.row == enPassantRow) {
			if (exists target = getEnPassantLocation(board, location)) {
				if (exists loc = target.relative(0, -direction)) {
					if (exists targetPiece = board.getPiece(loc)) {
						moves.proposeStrike(target, targetPiece);
					}
				}
			}
		}
		
		return moves.list;
	}

	shared Boolean doubleMoveBlocked(Board board, Location location) {
		if (exists loc = location.relative(0, direction)) {
			return board.getPiece(loc) exists;
		} else {
			return true;
		}
	}
	
	shared Location? getEnPassantLocation(Board board, Location location) {
		if (exists last = lastMove()) { // begin of game => no en passant
			if (!(last.piece is Pawn)) { // no pawn moved => no en passant
				return null;
			} else if (last.rowDistance() != 2) { // pawn moved one field => no en passant
				return null;
			} else if (location.colDistanceTo(last.to) != 1) { // not adjacent col => no en passant
				return null;
			} else if (location.rowDistanceTo(last.to) == 0) { // same row => en passant
				return last.to.relative(0, direction);
			} else { // else => no en passant
				return null;
			}
		}
		return null;
	}
	
	shared actual Result? accept<Result>(PieceVisitor<Result> visitor) {
		return visitor.visitPawn(this);
	}

}
