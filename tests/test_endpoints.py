import pytest


@pytest.fixture
def client():
    from app import app
    
    from fastapi.testclient import TestClient

    client = TestClient(app)
    return client


def test_root_endpoint(client):
    response = client.get("/")
    assert response.status_code == 200
