import ceylon.test { assertEquals, test }
import com.almondarts.chess { white, black }

shared class ColorTest() {
	
	test
	shared void testGetOpponent() {
		assertEquals(black.opponent, white);
		assertEquals(white.opponent, black);
	}

}