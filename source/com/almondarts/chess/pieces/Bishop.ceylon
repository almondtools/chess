import com.almondarts.chess {
	Game,
	Piece,
	Color,
	Location,
	Board,
	Move, PieceVisitor
}
import com.almondarts.chess.pieces { AbstractPiece, PossibleMovesBuilder, LegalMovesBuilder, MovesBuilder }

shared class Bishop(Game game, Color color) extends AbstractPiece(game, color) satisfies Piece {

	shared actual String name = "bishop";
	shared actual Character[] symbols = ['\{#2657}','\{#265D}'];

	shared actual List<Move> possibleMoves(Board board, Location location) {
		return computeMoves(PossibleMovesBuilder(board, this, location), location);
	}

	shared actual List<Move> legalMoves(Board board, Location location) {
		return computeMoves(LegalMovesBuilder(board, this, location), location);
	}

	List<Move> computeMoves(MovesBuilder moves, Location location) {
		moves.proposeMoveOrStrikeBreakingOnFirstObstacle(computeIncrementingSumDiagonalLocations(location));
		moves.proposeMoveOrStrikeBreakingOnFirstObstacle(computeDecrementingSumDiagonalLocations(location));
		moves.proposeMoveOrStrikeBreakingOnFirstObstacle(computeIncrementingDiffDiagonalLocations(location));
		moves.proposeMoveOrStrikeBreakingOnFirstObstacle(computeDecrementingDiffDiagonalLocations(location));
		
		return moves.list;
	}
	
	shared actual Result? accept<Result>(PieceVisitor<Result> visitor) {
		return visitor.visitBishop(this);
	}
}
