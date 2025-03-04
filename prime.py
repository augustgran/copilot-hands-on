
def is_prime(n):
    """
    Check if a given number is prime.

    A prime number is a natural number greater than 1 that is only divisible by 1 and itself.
    This function implements an efficient primality test by:
    1. Checking base cases (n < 2, n < 4)
    2. Checking if number is even
    3. Checking odd divisors up to square root of n

    Args:
      n (int): The number to test for primality

    Returns:
      bool: True if the number is prime, False otherwise

        Note:
          - Numbers less than 2 are not prime by definition
          - Numbers 2 and 3 are prime
          - All even numbers greater than 2 are not prime
          - Only need to check odd divisors up to sqrt(n)
          - Uses generators and 'all' for efficient testing
          - Time complexity: O(sqrt(n))
          - Space complexity: O(1)

    Example:
      >>> is_prime(17)
      True
      >>> is_prime(4)
      False
    """
    if n < 2:
        return False
    if n < 4:
        return True
    if n % 2 == 0:
        return False
    return all(n % i != 0 for i in range(3, int(n ** 0.5) + 1, 2))
