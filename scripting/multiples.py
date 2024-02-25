import ast
import sys


def calculate(limit, multiples):
    answer = 0
    valid_mults = []
    for i in range(1, limit):
        for j in multiples:
            if i % j == 0:
                if i not in valid_mults:
                    valid_mults.append(i)
    for k in valid_mults:
        sum += k
    return answer


def main():
    inputs = readInput()
    for lim, mults in inputs:
        ans = calculate(lim, mults)
        print(ans)


def readInput():
    inputs = []
    for line in sys.stdin:
        input_string = line.strip()
        limit_str, multiples_str = input_string.split(' ', 1)
        limit = int(limit_str)
        multiples = ast.literal_eval(multiples_str)
        inputs.append((limit, multiples))
    return inputs


cases = [
    [10, [3, 5]],        # Expected output: 23
    [10, [2, 3]],        # Expected output: 22
    [100, [1, 2, 3, 4]], # Expected output: 2418
    [25, [4, 2, 9, 7, 5]], # Expected output: 64
    [150, [3, 30, 15, 25]], # Expected output: 2213
    [1, [1]],            # Expected output: 0 (No multiples below 1)
    [1000, [2, 3, 5, 7]], # Expected output: 214216
    [50, [1]],           # Expected output: 1225 (Sum of integers below 50)
    [0, [3, 5]],         # Expected output: 0 (No multiples below 0)
]

for case in cases:
    ans = calculate(case[0], case[1])
    print(ans)