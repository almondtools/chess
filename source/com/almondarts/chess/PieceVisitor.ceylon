import com.almondarts.chess.pieces { Pawn, Bishop, Knight, Rook, Queen, King }
shared interface PieceVisitor<out Result> {

	shared formal Result visitPawn(Pawn pawn);
	shared formal Result visitBishop(Bishop bishop);
	shared formal Result visitKnight(Knight knight);
	shared formal Result visitRook(Rook rook);
	shared formal Result visitQueen(Queen queen);
	shared formal Result visitKing(King king);

}
