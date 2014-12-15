import com.almondarts.chess {
	Game,
	Piece,
	Color,
	Location,
	Board,
	Move, PieceVisitor
}
import com.almondarts.chess.pieces { AbstractPiece, PossibleMovesBuilder, LegalMovesBuilder, MovesBuilder }

shared class Knight(Game game, Color color) extends AbstractPiece(game, color) satisfies Piece {

	shared actual String name = "knight";
	shared actual Character[] symbols = ['\{#2658}','\{#265E}'];

	shared actual List<Move> possibleMoves(Board board, Location location) {
		return computeMoves(PossibleMovesBuilder(board, this, location), location);
	}

	shared actual List<Move> legalMoves(Board board, Location location) {
		return computeMoves(LegalMovesBuilder(board, this, location), location);
	}

	List<Move> computeMoves(MovesBuilder moves, Location location) {
		for (colOffset in (-2..2).by(4)) {
			for (rowOffset in (-1..1).by(2)) {
				if (exists loc = location.relative(colOffset, rowOffset)) {
					moves.proposeMoveOrStrike(loc);
				}
			}
		}
		for (rowOffset in (-2..2).by(4)) {
			for (colOffset in (-1..1).by(2)) {
				if (exists loc = location.relative(colOffset, rowOffset)) {
					moves.proposeMoveOrStrike(loc);
				}
			}
		}
		
		return moves.list;
	}
	
	shared actual Result? accept<Result>(PieceVisitor<Result> visitor) {
		return visitor.visitKnight(this);
	}
}
