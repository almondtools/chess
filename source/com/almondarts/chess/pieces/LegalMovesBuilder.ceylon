import com.almondarts.chess { Board, Piece, Location, Move }

shared class LegalMovesBuilder(Board board, Piece piece, Location location) extends MovesBuilder(board, piece, location) {

	shared actual void propose(Move move) {
		if (board.legalMove(move)) {
			moves.add(move);
		}
	}
}