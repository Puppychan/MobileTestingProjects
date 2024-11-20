# Ref: https://oeis.org/A000217
# Based on triangular numbers
# Original equation: n(n+1)/2 = sum of numbers from 1 to n having n numbers
# Replace n with (n + 1) 
# => Rearranged equation: (n+1)(n+1+1)/2 => (n+1)(n+2)/2 = sum of numbers from 1 to n+1 having n+1 numbers

def find_missing_number(arr):
    # Get the length of the array
    n = len(arr)
    # Calculate the expected sum of numbers from 1 to n+1 using above equation
    expected_sum = (n + 1) * (n + 2) // 2  # Sum of numbers from 1 to n+1
    # Calculate the actual sum of numbers in the array
    actual_sum = sum(arr)
    # The difference between the expected sum and the actual sum is the missing number
    return expected_sum - actual_sum  # The missing number

# Test
arr = [3, 7, 1, 2, 6, 4]
missing_number = find_missing_number(arr)
print(f"The missing number is: {missing_number}")
