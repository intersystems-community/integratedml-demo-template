"""
Integration tests for InterSystems IRIS IntegratedML Demo

These tests verify:
1. Connection to IRIS works
2. Sample data tables exist and have data
3. Basic SQL queries work
4. IntegratedML commands can be executed

Run with: pytest tests/ -v
Requires: docker-compose up -d (IRIS container running)
"""

import pytest
import os

# Skip all tests if iris module not available (CI environment without IRIS)
iris = pytest.importorskip("iris")


# Connection configuration - uses environment variables or defaults
CONNECTION_STRING = os.getenv("IRIS_CONNECTION", "localhost:8091/USER")
USERNAME = os.getenv("IRIS_USERNAME", "SUPERUSER")
PASSWORD = os.getenv("IRIS_PASSWORD", "SYS")


@pytest.fixture(scope="module")
def iris_connection():
    """Create a connection to IRIS for all tests in this module."""
    try:
        conn = iris.connect(CONNECTION_STRING, USERNAME, PASSWORD)
        yield conn
        conn.close()
    except Exception as e:
        pytest.skip(f"Could not connect to IRIS: {e}")


@pytest.fixture
def cursor(iris_connection):
    """Create a cursor for each test."""
    return iris_connection.cursor()


class TestConnection:
    """Test basic IRIS connectivity."""

    def test_connection_established(self, iris_connection):
        """Verify we can establish a connection."""
        assert iris_connection is not None

    def test_cursor_creation(self, cursor):
        """Verify we can create a cursor."""
        assert cursor is not None

    def test_simple_query(self, cursor):
        """Verify we can run a simple SQL query."""
        cursor.execute("SELECT 1 AS test_value")
        result = cursor.fetchone()
        assert result is not None
        assert result[0] == 1


class TestSampleData:
    """Test that sample data tables exist and have data."""

    @pytest.mark.parametrize("table_name,min_rows", [
        ("Marketing.Campaign", 1000),
        ("Patient.Readmission", 1000),
        ("Biomedical.BreastCancer", 100),
        ("Titanic.Passenger", 100),
    ])
    def test_table_has_data(self, cursor, table_name, min_rows):
        """Verify sample data tables have expected minimum rows."""
        cursor.execute(f"SELECT COUNT(*) FROM {table_name}")
        result = cursor.fetchone()
        assert result is not None, f"No result from {table_name}"
        count = result[0]
        assert count >= min_rows, f"{table_name} has {count} rows, expected >= {min_rows}"


class TestIntegratedML:
    """Test IntegratedML functionality."""

    @pytest.fixture(autouse=True)
    def setup_teardown(self, cursor):
        """Clean up any test models before and after tests."""
        # Cleanup before
        try:
            cursor.execute("DROP MODEL IF EXISTS TestModel")
        except:
            pass

        yield

        # Cleanup after
        try:
            cursor.execute("DROP MODEL IF EXISTS TestModel")
        except:
            pass

    def test_ml_configuration_query(self, cursor):
        """Verify we can query ML configurations."""
        cursor.execute("SELECT * FROM INFORMATION_SCHEMA.ML_CONFIGURATIONS")
        # Should not raise an error
        result = cursor.fetchall()
        assert result is not None

    def test_create_model(self, cursor):
        """Test creating an IntegratedML model definition."""
        cursor.execute("""
            CREATE MODEL TestModel
            PREDICTING (RESPONSE)
            FROM Marketing.Campaign
        """)

        # Verify model exists
        cursor.execute("""
            SELECT MODEL_NAME
            FROM INFORMATION_SCHEMA.ML_MODELS
            WHERE MODEL_NAME = 'TestModel'
        """)
        result = cursor.fetchone()
        assert result is not None
        assert result[0].upper() == "TESTMODEL"

    @pytest.mark.slow
    def test_train_model(self, cursor):
        """Test training an IntegratedML model (slow test)."""
        # Create model first
        cursor.execute("""
            CREATE MODEL TestModel
            PREDICTING (RESPONSE)
            FROM (SELECT TOP 500 * FROM Marketing.Campaign)
        """)

        # Train the model (this can take a while)
        cursor.execute("TRAIN MODEL TestModel")

        # Verify trained model exists
        cursor.execute("""
            SELECT TRAINED_MODEL_NAME
            FROM INFORMATION_SCHEMA.ML_TRAINED_MODELS
            WHERE MODEL_NAME = 'TestModel'
        """)
        result = cursor.fetchone()
        assert result is not None


class TestPandasIntegration:
    """Test pandas integration with IRIS connection."""

    def test_read_sql_with_pandas(self, iris_connection):
        """Verify pandas can read data from IRIS."""
        pd = pytest.importorskip("pandas")

        df = pd.read_sql("SELECT TOP 10 * FROM Marketing.Campaign", iris_connection)

        assert df is not None
        assert len(df) == 10
        assert "RESPONSE" in df.columns or "response" in [c.lower() for c in df.columns]

    def test_dataframe_types(self, iris_connection):
        """Verify pandas correctly interprets column types."""
        pd = pytest.importorskip("pandas")

        df = pd.read_sql("SELECT TOP 5 AGE, EDUCATION, RESPONSE FROM Marketing.Campaign", iris_connection)

        assert len(df) == 5
        # AGE should be numeric
        assert df["AGE"].dtype in ["int64", "float64", "int32", "float32"]
