import ceylon.test { assertEquals, test, assertTrue }
import com.almondarts.chess { Location, Game, Move, Board, white, location, black, a, b, c, d, e, f, g, h }
import com.almondarts.chess.pieces { Rook, TestPiece, King }

shared class RookTest() {

	Game game = Game();
	Board board = game.board; 

	test
	shared void getName()  {
		assertEquals(game.rook(white).name, "rook");
	}

	test
	shared void testThatRookCanMoveStraight() {
		Rook rook = game.rook(white);
		List<Move> possibleMoves = rook.possibleMoves(board, location(f, 4));

		assertTrue(possibleMoves.every((Move move) => move.piece == rook));
		assertTrue(possibleMoves.every((Move move) => move.from == location(f, 4)));
		
		assertEquals(possibleMoves.size, 14);

		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 4)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(d, 4)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(c, 4)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 4)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(a, 4)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(g, 4)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(h, 4)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 3)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 2)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 1)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 5)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 6)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 7)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 8)));
	}

	
	test
	shared void testThatRookCanStrikeStraight() {
		board.putPiece(TestPiece(black), location(d, 4));
		board.putPiece(TestPiece(black), location(h, 4));
		board.putPiece(TestPiece(black), location(f, 2));
		board.putPiece(TestPiece(black), location(f, 7));

		Rook rook = game.rook(white);
		List<Move> possibleMoves = rook.possibleMoves(board, location(f, 4));

		assertTrue(possibleMoves.every((Move move) => move.piece == rook));
		assertTrue(possibleMoves.every((Move move) => move.from == location(f, 4)));
		
		assertEquals(possibleMoves.size, 9);
		
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 4) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(d, 4) && move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(g, 4) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(h, 4) && move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 3) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 2) && move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 5) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 6) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 7) && move.capturing));
	}

	
	test
	shared void testThatRookCannotJumpOverOwnColor() {
		board.putPiece(TestPiece(white), location(d, 4));

		Rook rook = game.rook(white);
		List<Move> possibleMoves = rook.possibleMoves(board, location(e, 4));

		assertTrue(possibleMoves.every((Move move) => move.piece == rook));
		assertTrue(possibleMoves.every((Move move) => move.from == location(e, 4)));
		
		assertEquals(possibleMoves.size, 10);
		
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 4) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(g, 4) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(h, 4) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 3) && !move.capturing));

		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 2) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 1) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 5) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 6) && !move.capturing));

		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 7) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 8) && !move.capturing));
	}

	
	test
	shared void testThatRookCannotJumpOverOpponentColor() {
		TestPiece pieceD4 = TestPiece(black);
		board.putPiece(pieceD4, location(d, 4));

		Rook rook = game.rook(white);
		List<Move> possibleMoves = rook.possibleMoves(board, location(e, 4));

		assertTrue(possibleMoves.every((Move move) => move.piece == rook));
		assertTrue(possibleMoves.every((Move move) => move.from == location(e, 4)));
		
		assertEquals(possibleMoves.size, 11);
		
		assertTrue(possibleMoves.any((Move move) => move.to == location(d, 4) && move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 4) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(g, 4) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(h, 4) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 3) && !move.capturing));

		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 2) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 1) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 5) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 6) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 7) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 8) && !move.capturing));
	}

	test
	shared void testThatRookCannotMoveFreelyIfKingIsInCheck() {
		King king = game.king(white);
		board.putPiece(king, location(d, 2));
		object piece extends TestPiece(black) {
			shared actual List<Move> possibleMoves(Board board, Location loc) {
				if (board.getPiece(location(d, 2))?.equals(king) else false) {
					return [Move(this, location(c, 2), location(d, 2), king)];
				} else {
					return [];
				}
			}
		}
		board.putPiece(piece, location(c, 2));

		Rook rook = game.rook(white);
		List<Move> possibleMoves = rook.legalMoves(board, location(e, 4));

		assertEquals(possibleMoves.size, 0);
	}

	test
	shared void testThatRookCannotMoveFreelyIfKingGetsInCheck() {
		King king = game.king(white);
		board.putPiece(king, location(d, 2));
		object piece extends TestPiece(black) {
			shared actual List<Move> possibleMoves(Board board, Location loc) {
				if (board.getPiece(location(e, 4)) exists) {
					return [];
				} else {
					return [Move(this, location(c, 2), location(d, 2), king)];
				}
			}
		}
		board.putPiece(piece, location(c, 2));

		Rook rook = game.rook(white);
		List<Move> possibleMoves = rook.legalMoves(board, location(e, 4));

		assertEquals(possibleMoves.size, 0);
	}

}
