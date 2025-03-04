import pytest
from prime import is_prime

def test_small_prime_numbers():
  """Test known small prime numbers"""
  assert is_prime(2) is True
  assert is_prime(3) is True
  assert is_prime(17) is True
  assert is_prime(31) is True

def test_small_composite_numbers():
  """Test known small composite (non-prime) numbers"""
  assert is_prime(4) is False
  assert is_prime(9) is False
  assert is_prime(15) is False

def test_edge_cases():
  """Test edge cases including 0, 1 and negative numbers"""
  assert is_prime(0) is False
  assert is_prime(2) is False
  assert is_prime(-5) is False

def test_large_numbers():
  """Test some larger prime and non-prime numbers"""
  assert is_prime(997) is True  # Large prime
  assert is_prime(100) is False  # Large composite

def test_type_errors():
  """Test that non-integer inputs raise TypeError"""
  with pytest.raises(TypeError):
    is_prime(3.14)