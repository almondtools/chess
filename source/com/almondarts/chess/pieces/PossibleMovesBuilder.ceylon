import com.almondarts.chess { Board, Piece, Location, Move }

shared class PossibleMovesBuilder(Board board, Piece piece, Location location) extends MovesBuilder(board, piece, location) {

	shared actual void propose(Move move) {
		moves.add(move);
	}
}