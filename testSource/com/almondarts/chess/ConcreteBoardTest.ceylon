import ceylon.collection {
	HashMap
}
import ceylon.test {
	assertEquals,
	test,
	assertTrue,
	assertNull,
	assertFalse
}

import com.almondarts.chess {
	white
}
import com.almondarts.chess.pieces {
	TestPiece,
	King
}

shared class ConcreteBoardTest() {

	Game game = Game();
	variable Board board = ConcreteBoard();

	test
	shared void testConstructor() {
		board = ConcreteBoard(HashMap{location(a, 1) -> TestPiece(white)});
		assertEquals(board.getPiecesByColor(black).size, 0);
		assertTrue(board.getPiecesByColor(white).any((Piece->Location entry) => entry.key.color == white && entry.item == location(a, 1)));
	}
	
	test
	shared void testGetPiecesByColor() {
		board.putPiece(TestPiece(white), location(a, 1));
		assertEquals(board.getPiecesByColor(black).size, 0);
		assertTrue(board.getPiecesByColor(white).any((Piece->Location entry) => entry.key.color == white && entry.item == location(a, 1)));
	}

	test
	shared void testGetPiecesByLocation() {
		Piece testPiece = TestPiece(white);
		board.putPiece(testPiece, location(a, 1));
		assertEquals(board.getPiece(location(a, 1)), testPiece);
	}

	test
	shared void testGetPiecesAll() {
		board.putPiece(TestPiece(white), location(a, 1));
		board.putPiece(TestPiece(black), location(h, 8));
		Map<Piece, Location> all = board.getPieces();
		assertEquals(all.size, 2);
		assertTrue(all.any((Piece->Location entry) => entry.key.color == white && entry.item == location(a, 1)));
		assertTrue(all.any((Piece->Location entry) => entry.key.color == black && entry.item == location(h, 8)));
	}

	test
	shared void testGetPiecesRemoveByLocation() {
		board.putPiece(TestPiece(white), location(a, 1));
		board.removeLocation(location(a, 1));
		assertEquals(board.getPieces().size, 0);
	}

	test
	shared void testGetPiecesRemoveByPiece() {
		TestPiece piece = TestPiece(white);
		board.putPiece(piece, location(a, 1));
		board.removePiece(piece);
		assertEquals(board.getPieces().size, 0);
	}

	test
	shared void testGetPiecesRemoveByPieceWithMoreThanOnePiece() {
		TestPiece whiteH8 = TestPiece(white);
		TestPiece whiteH7 = TestPiece(white);
		TestPiece blackA1 = TestPiece(black);
		board.putPiece(whiteH8, location(h, 8));
		board.putPiece(whiteH7, location(h, 7));
		board.putPiece(blackA1, location(a, 1));
		
		board.removePiece(whiteH8);
		
		assertEquals(board.getPieces().size, 2);
		assertTrue(board.getPieces().any((Piece->Location entry) => entry.key.color == white && entry.item == location(h, 7)));
		assertTrue(board.getPieces().any((Piece->Location entry) => entry.key.color == black && entry.item == location(a, 1)));
	}

	test
	shared void testGetPiecesReplace() {
		board.putPiece(TestPiece(white), location(a, 1));
		board.putPiece(TestPiece(black), location(a, 1));
		assertEquals(board.getPiece(location(a, 1))?.color, black);
	}

	test
	shared void testThatPuttingAPieceOnTheBoardMakesFieldOccupiedWithPiece() {
		TestPiece testpiece = TestPiece(white);
		board.putPiece(testpiece, location(b, 7));

		assertEquals(board.getPiece(location(b, 7)), testpiece);
	}

	test
	shared void testThatRemovingAPieceLeavesFieldUnoccupied() {
		TestPiece testpiece = TestPiece(white);
		board.putPiece(testpiece, location(b, 7));
		board.removeLocation(location(b, 7));

		assertNull(board.getPiece(location(b, 7)));
	}

	test
	shared void testThatApplyingMoveChangesBoard() {
		TestPiece testpiece = TestPiece(white);
		board.putPiece(testpiece, location(b, 7));
		board = board.apply(Move(testpiece, location(b, 7), location(b, 6)));

		assertNull(board.getPiece(location(b, 7)));
		assertEquals(board.getPiece(location(b, 6)), testpiece);
	}

	test
	shared void testThatSituationWithTheOpponentKingBeingStrikableIsNotLegal() {
		King blackking = game.king(black);
		board.putPiece(blackking, location(c, 4));
		object whitepiece extends TestPiece(white) {
			
			shared actual List<Move> possibleMoves(Board board, Location loc) {
				return [Move(this, location(c, 5), location(c, 4), blackking)];
			}
		}
		board.putPiece(whitepiece, location(c, 5));

		assertFalse(board.legalScenario(white));
	}

	test
	shared void testThatSituationWithTheOpponentKingNotBeingStrikableIsLegal() {
		King blackking = game.king(black);
		board.putPiece(blackking, location(c, 4));
		object whitepiece extends TestPiece(white) {
			
			shared actual List<Move> possibleMoves(Board board, Location loc) {
				return [Move(this, location(c, 5), location(c, 6))];
			}
		}
		board.putPiece(whitepiece, location(c, 5));

		assertTrue(board.legalScenario(black));
		assertTrue(board.legalScenario(white));
	}

	test
	shared void testThatSituationWithTheCurrentKingBeingStrikableIsNotLegal() {
		King whiteking = game.king(white);
		board.putPiece(whiteking, location(c, 4));
		object blackpiece extends TestPiece(black) {
			
			shared actual List<Move> possibleMoves(Board board, Location loc) {
				return [Move(this, location(c, 5), location(c, 4), whiteking)];
			}
		}
		board.putPiece(blackpiece, location(c, 5));

		assertTrue(board.legalScenario(white));
		assertFalse(board.legalScenario(black));
	}

}
