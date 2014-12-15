import com.almondarts.chess {
	Game,
	Piece,
	Color
}

shared class WhitePawn(Game game, Color color) extends Pawn(game, color) satisfies Piece {

	shared actual Integer startRow = 2;
	shared actual Integer enPassantRow = 5;
	
}
