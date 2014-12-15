import com.almondarts.chess {
	Game,
	Piece,
	Color
}
import com.almondarts.chess.pieces { Pawn }

shared class BlackPawn(Game game, Color color) extends Pawn(game, color) satisfies Piece {

	shared actual Integer startRow = 7;
	shared actual Integer enPassantRow = 4;
	
}
