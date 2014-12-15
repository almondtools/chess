import ceylon.test { assertEquals, assertThatException, test, assertNotNull }
import java.lang {Math {sqrt, abs}}
import com.almondarts.chess { f, d, b, location, a, internal, h }

shared class LocationTest() {
	
	test
	shared void locationToString() {
		assertEquals(location(a, 1).string, "a1");
		assertEquals(location(b, 1).string, "b1");
		assertEquals(location(b, 2).string, "b2");
		assertEquals(location(h, 8).string, "h8");
		
		assertThatException(() => location(h + 1, 4));
		assertThatException(() => location(a - 1, 4));
		assertThatException(() => location(d, 0));
		assertThatException(() => location(d, 9));
	}

	test
	shared void internalToString() {
		assertEquals(internal(0, 0).string, "a1");
		assertEquals(internal(1, 0).string, "b1");
		assertEquals(internal(1, 1).string, "b2");
		assertEquals(internal(7, 7).string, "h8");

		assertThatException(() => internal(8, 4));
		assertThatException(() => internal(-1, 4));
		assertThatException(() => internal(4, -1));
		assertThatException(() => internal(4, 8));
	}

	test
	shared void testThatIdIsConformToConstructorArguments() {
		assertEquals(location(a, 1).id, "a1");
		assertEquals(location(b, 1).id, "b1");
		assertEquals(location(b, 2).id, "b2");
		assertEquals(location(h, 8).id, "h8");
	}

	test
	shared void testThatAllLegalLocationsAreAvailable() {
		assertNotNull(location(a, 1));
		assertNotNull(location(a, 2));
		assertNotNull(location(b, 2));
		assertNotNull(location(h, 8));
	}

	test
	shared void testThatIllegalLocationsAreNotAvailable() {
		assertThatException(() => location(a - 1, 8));
		assertThatException(() => location(h + 1, 8));
		assertThatException(() => location(a, 0));
		assertThatException(() => location(a, 9));
	}

	test
	shared void testThatDistanceReturnsEuklidsMetricBasedOnFields() {
		assertEquals(location(a, 1).distanceTo(location(a, 2)), 1, null, equalsFloatCompare(0.01));
		assertEquals(location(a, 1).distanceTo(location(b, 2)), sqrt(2.0), null, equalsFloatCompare(0.01));
		assertEquals(location(a, 1).distanceTo(location(b, 3)), sqrt(5.0), null, equalsFloatCompare(0.01));
		assertEquals(location(a, 1).distanceTo(location(d, 5)), 5, null, equalsFloatCompare(0.01));
	}

	test
	shared void testLegalRelativeTransposing() {
		assertEquals(location(a, 1).relative(1, 0), location(b, 1));
		assertEquals(location(a, 1).relative(1, 1), location(b, 2));
		assertEquals(location(h, 5).relative(-2, -3), location(f, 2));
		assertEquals(location(h, 5).relative(-2, 1), location(f, 6));
	}

	test
	shared void testIllegalRelativeTransposing() {
		assertEquals(location(a, 1).relative(-1, 0), null);
		assertEquals(location(a, 1).relative(0, -1), null);
		assertEquals(location(h, 4).relative(0, 5), null);
		assertEquals(location(h, 4).relative(1, 0), null);
	}

	test
	shared void testGetColRow() {
		assertEquals(location(a, 1).col, a);
		assertEquals(location(b, 1).col, b);
		assertEquals(location(b, 2).col, b);
		assertEquals(location(h, 8).col, h);

		assertEquals(location(a, 1).row, 1);
		assertEquals(location(b, 1).row, 1);
		assertEquals(location(b, 2).row, 2);
		assertEquals(location(h, 8).row, 8);
	}

	test
	shared void testGetColRowIndex() {
		assertEquals(location(a, 1).colIndex, 0);
		assertEquals(location(b, 1).colIndex, 1);
		assertEquals(location(b, 2).colIndex, 1);
		assertEquals(location(h, 8).colIndex, 7);

		assertEquals(location(a, 1).rowIndex, 0);
		assertEquals(location(b, 1).rowIndex, 0);
		assertEquals(location(b, 2).rowIndex, 1);
		assertEquals(location(h, 8).rowIndex, 7);
	}

	test
	shared void testColDistanceTo() {
		assertEquals(location(a, 1).colDistanceTo(location(b, 1)), 1);
		assertEquals(location(a, 1).colDistanceTo(location(b, 2)), 1);
		assertEquals(location(a, 1).colDistanceTo(location(d, 5)), 3);
		assertEquals(location(a, 1).colDistanceTo(location(h, 8)), 7);
	}

	test
	shared void testRowDistanceTo() {
		assertEquals(location(a, 1).rowDistanceTo(location(b, 1)), 0);
		assertEquals(location(a, 1).rowDistanceTo(location(b, 2)), 1);
		assertEquals(location(a, 1).rowDistanceTo(location(d, 5)), 4);
		assertEquals(location(a, 1).rowDistanceTo(location(h, 8)), 7);
	}

	Boolean equalsFloatCompare(Float threshold)(Anything obj1, Anything obj2) {
    	if (is Float obj1) {
        	if (is Float obj2) {
            	return abs(obj1 - obj2) < threshold;
        	}
    	}
    	return obj1 exists == obj2 exists;
    }

}