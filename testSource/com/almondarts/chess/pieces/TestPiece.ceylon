import com.almondarts.chess { Piece, Location, Board, Move, Color, PieceVisitor }
import ceylon.collection { LinkedList }
shared class TestPiece(color) satisfies Piece {

	shared actual String name = "test";
	shared actual Character symbol = '*';
	shared actual String prefix = "*";
	shared actual Color color;
	
	shared actual default List<Move> possibleMoves(Board board, Location location) {
		return LinkedList();
	}
	
	shared actual default List<Move> legalMoves(Board board, Location location) {
		return possibleMoves(board, location);
	}
	
	shared actual Boolean opponent(Piece other) {
		return color != other.color;
	}

	shared actual Result? accept<Result>(PieceVisitor<Result> visitor) {
		return null;
	}

}