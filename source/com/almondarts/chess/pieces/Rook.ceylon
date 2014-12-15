import com.almondarts.chess {
	Game,
	Piece,
	Color,
	Location,
	Board,
	Move, PieceVisitor
}
import com.almondarts.chess.pieces { AbstractPiece, PossibleMovesBuilder, LegalMovesBuilder, MovesBuilder }

shared class Rook(Game game, Color color) extends AbstractPiece(game, color) satisfies Piece {

	shared actual String name = "rook";
	shared actual Character[] symbols = ['\{#2656}','\{#265C}'];

	shared actual List<Move> possibleMoves(Board board, Location location) {
		return computeMoves(PossibleMovesBuilder(board, this, location), location);
	}

	shared actual List<Move> legalMoves(Board board, Location location) {
		return computeMoves(LegalMovesBuilder(board, this, location), location);
	}

	List<Move> computeMoves(MovesBuilder moves, Location location) {
		moves.proposeMoveOrStrikeBreakingOnFirstObstacle(computeIncrementingRowLocations(location));
		moves.proposeMoveOrStrikeBreakingOnFirstObstacle(computeDecrementingRowLocations(location));
		moves.proposeMoveOrStrikeBreakingOnFirstObstacle(computeIncrementingColLocations(location));
		moves.proposeMoveOrStrikeBreakingOnFirstObstacle(computeDecrementingColLocations(location));
		
		return moves.list;
	}

	shared actual Result? accept<Result>(PieceVisitor<Result> visitor) {
		return visitor.visitRook(this);
	}
}
