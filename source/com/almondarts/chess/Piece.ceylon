shared interface Piece {

	shared formal String name;
	shared formal Character symbol;
	shared formal String prefix;
	shared formal Color color;
	shared Color getOpponentColor => color.opponent;
	shared formal List<Move> possibleMoves(Board board, Location location);
	shared formal List<Move> legalMoves(Board board, Location location);
	shared formal Boolean opponent(Piece other);
	shared formal Result? accept<Result>(PieceVisitor<Result> visitor);

}