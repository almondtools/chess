import ceylon.test { assertEquals, test, assertTrue }
import com.almondarts.chess { Location, Game, Move, Board, white, location, black, a, b, c}
import com.almondarts.chess.pieces { TestPiece, King }
import ceylon.math.float { sqrt }

shared class KingTest() {

	Game game = Game();
	Board board = game.board; 

	test
	shared void getName()  {
		assertEquals(game.king(white).name, "king");
	}

	test
	shared void kingMovesMaximumOneField() {
		King king = game.king(white);
		List<Move> possibleMoves = king.possibleMoves(board, location(b, 7));
		
		assertEquals(possibleMoves.size, 8);
		assertTrue(possibleMoves.every((Move move) => !move.capturing));
		assertTrue(possibleMoves.every((Move move) => move.from == location(b, 7)));
		assertTrue(possibleMoves.every((Move move) => move.distance == 1.0 || move.distance == sqrt(2.0)));
	}
	
	test
	shared void testThatKingIsInhibitedByOwnPieces() {
		board.putPiece(TestPiece(white), location(b, 8));
		
		King king = game.king(white);
		List<Move> possibleMoves = king.possibleMoves(board, location(b, 7));
		
		assertEquals(possibleMoves.size, 7);
		assertTrue(possibleMoves.every((Move move) => !move.capturing));
		assertTrue(possibleMoves.every((Move move) => move.from == location(b, 7)));
		assertTrue(possibleMoves.every((Move move) => move.distance == 1.0 || move.distance == sqrt(2.0)));
		assertTrue(possibleMoves.every((Move move) => move.to != location(b, 8)));
	}
	
	test
	shared void testThatKingStrikesOpponentPiecesIfNecessary() {
		TestPiece pieceB8 = TestPiece(black);
		board.putPiece(pieceB8, location(b, 8));
		
		King king = game.king(white);
		List<Move> possibleMoves = king.possibleMoves(board, location(b, 7));
		
		assertEquals(possibleMoves.size, 8);
		assertTrue(possibleMoves.any((Move move) => move.piece == king && (move.targetPiece?.equals(pieceB8) else false) && move.from == location(b, 7) && move.to == location(b, 8)));
	}
	
	test
	shared void testThatKingDoesNeverMoveToIllegalSituation() {
		King king = game.king(white);

		object pieceB8 extends TestPiece(black) {
			shared actual List<Move> possibleMoves(Board board, Location loc) {
				if (board.getPiece(location(a, 7))?.equals(king) else false) {
					return [Move(this, location(b, 8), location(a, 7), king)];
				} else {
					return [];
				}
			}
		}
		board.putPiece(pieceB8, location(b, 8));
		object pieceC7 extends TestPiece(black) {
			shared actual List<Move> possibleMoves(Board board, Location loc) {
				if (board.getPiece(location(b, 8))?.equals(king) else false) {
					return [Move(this, location(c, 7), location(b, 8), king)];
				} else {
					return [];
				}
			}
		}
		board.putPiece(pieceC7, location(c, 7));

		List<Move> possibleMoves = king.legalMoves(board, location(b, 7));

		assertEquals(possibleMoves.size, 6);
		assertTrue(possibleMoves.every((Move move) => move.piece == king));
		assertTrue(possibleMoves.every((Move move) => move.from == location(b, 7)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(a, 6) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(a, 8) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 6) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(c, 6) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(c, 7) && (move.targetPiece?.equals(pieceC7) else false)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(c, 8) && !move.capturing));
	}

}
