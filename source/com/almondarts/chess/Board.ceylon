import com.almondarts.chess { Piece, Location, Move, Color }
shared interface Board {
		
	shared formal Board apply(Move move);
	shared formal Board assume(Move move);
	shared formal Board putPiece(Piece piece, Location location);
	shared formal Board removePiece(Piece piece);
	shared formal Board removeLocation(Location location);
	shared formal Piece? getPiece(Location location);
	shared formal Map<Piece,Location> getPieces();
	shared formal Map<Piece,Location> getPiecesByColor(Color criteria);
	shared formal List<Piece->Location> getSortedPieces();
	shared formal Boolean legalMove(Move move);
	shared formal Boolean legalScenario(Color color);
	shared formal List<Move> possibleMoves(Color color);
	shared formal List<Move> legalMoves(Color color);
	shared formal List<Move> computePossibleStrikes(Color color);
	shared formal List<Move> computeLegalStrikes(Color color);
		
}