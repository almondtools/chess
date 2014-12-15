import ceylon.test { assertEquals, test, assertTrue }
import com.almondarts.chess { Location, Game, Move, Board, white, location, black, a, b, c, d, e, f, g, h }
import com.almondarts.chess.pieces { Queen, TestPiece, King }

shared class QueenTest() {

	Game game = Game();
	Board board = game.board; 

	test
	shared void getName()  {
		assertEquals(game.queen(white).name, "queen");
	}

	test
	shared void testThatQueenCanMoveStraightAndDiagonal() {
		Queen queen = game.queen(white);
		List<Move> possibleMoves = queen.possibleMoves(board, location(b, 6));
		
		assertTrue(possibleMoves.every((Move move) => move.piece == queen));
		assertTrue(possibleMoves.every((Move move) => move.from == location(b, 6)));

		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 1) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 2) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 3) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 4) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 5) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 7) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 8) && !move.capturing));

		assertTrue(possibleMoves.any((Move move) => move.to == location(a, 6) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(c, 6) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(d, 6) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 6) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 6) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(g, 6) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(h, 6) && !move.capturing));

		assertTrue(possibleMoves.any((Move move) => move.to == location(a, 5) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(c, 7) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(d, 8) && !move.capturing));
			
		assertTrue(possibleMoves.any((Move move) => move.to == location(a, 7) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(c, 5) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(d, 4) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 3) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 2) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(g, 1) && !move.capturing));
	}
	
	test
	shared void testThatQueenCanStrikeStraightAndDiagonal() {
		board.putPiece(TestPiece(black), location(b, 2));
		board.putPiece(TestPiece(black), location(b, 8));
		board.putPiece(TestPiece(black), location(a, 6));
		board.putPiece(TestPiece(black), location(f, 6));
		board.putPiece(TestPiece(black), location(f, 2));
		board.putPiece(TestPiece(black), location(f, 7));
		board.putPiece(TestPiece(black), location(a, 5));
		board.putPiece(TestPiece(black), location(c, 7));
		board.putPiece(TestPiece(black), location(a, 7));
		board.putPiece(TestPiece(black), location(e, 3));

		Queen queen = game.queen(white);
		List<Move> possibleMoves = queen.possibleMoves(board, location(b, 6));

		assertTrue(possibleMoves.every((Move move) => move.piece == queen));
		assertTrue(possibleMoves.every((Move move) => move.from == location(b, 6)));
		
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 2) && move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 3) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 4) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 5) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 7) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 8) && move.capturing));
		
		assertTrue(possibleMoves.any((Move move) => move.to == location(a, 6) && move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(c, 6) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(d, 6) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 6) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 6) && move.capturing));
		
		assertTrue(possibleMoves.any((Move move) => move.to == location(a, 5) && move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(c, 7) && move.capturing));
		
		assertTrue(possibleMoves.any((Move move) => move.to == location(a, 7) && move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(c, 5) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(d, 4) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 3) && move.capturing));
	}

	test
	shared void testThatQueenCannotJumpOverOwnColor() {
		board.putPiece(TestPiece(white), location(d, 6));
		board.putPiece(TestPiece(white), location(d, 4));

		Queen queen = game.queen(white);
		List<Move> possibleMoves = queen.possibleMoves(board, location(b, 6));

		assertEquals(possibleMoves.size, 14);

		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 1) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 2) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 3) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 4) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 5) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 7) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 8) && !move.capturing));
		
		assertTrue(possibleMoves.any((Move move) => move.to == location(a, 6) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(c, 6) && !move.capturing));
		
		assertTrue(possibleMoves.any((Move move) => move.to == location(a, 5) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(c, 7) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(d, 8) && !move.capturing));
		
		assertTrue(possibleMoves.any((Move move) => move.to == location(a, 7) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(c, 5) && !move.capturing));
	}

	test
	shared void testThatQueenCannotJumpOverOpponentColor() {
		board.putPiece(TestPiece(black), location(d, 6));
		board.putPiece(TestPiece(black), location(d, 4));

		Queen queen = game.queen(white);
		List<Move> possibleMoves = queen.possibleMoves(board, location(b, 6));

		assertEquals(possibleMoves.size, 16);

		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 1) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 2) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 3) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 4) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 5) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 7) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 8) && !move.capturing));
		
		assertTrue(possibleMoves.any((Move move) => move.to == location(a, 6) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(c, 6) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(d, 6) && move.capturing));
		
		assertTrue(possibleMoves.any((Move move) => move.to == location(a, 5) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(c, 7) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(d, 8) && !move.capturing));
		
		assertTrue(possibleMoves.any((Move move) => move.to == location(a, 7) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(c, 5) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(d, 4) && move.capturing));
	}

	test
	shared void testThatQueenCannotMoveFreelyIfKingIsInCheck() {
		King king = game.king(white);
		board.putPiece(king, location(d, 2));
		object piece extends TestPiece(black) {
			
			shared actual List<Move> possibleMoves(Board board, Location loc) {
				if (board.getPiece(location(d, 2))?.equals(king) else false) {
					return [Move(this, location(c, 3), location(d, 2), king)];
				} else {
					return [];
				}
			}
		}
		board.putPiece(piece, location(c, 3));

		Queen queen = game.queen(white);
		List<Move> possibleMoves = queen.legalMoves(board, location(e, 4));

		assertEquals(possibleMoves.size, 0);
	}

	test
	shared void testThatQueenCannotMoveFreelyIfKingGetsInCheck() {
		King king = game.king(white);
		board.putPiece(king, location(d, 2));
		object piece extends TestPiece(black) {
			shared actual List<Move> possibleMoves(Board board, Location loc) {
				if (board.getPiece(location(e, 4)) exists) {
					return [];
				} else {
					return [Move(this, location(c, 3), location(d, 2), king)];
				}
			}
		}
		board.putPiece(piece, location(c, 3));

		Queen queen = game.queen(white);
		List<Move> possibleMoves = queen.legalMoves(board, location(e, 4));

		assertEquals(possibleMoves.size, 0);
	}

}
