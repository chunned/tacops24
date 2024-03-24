# Credit to TetCTF 2020, retrieved from CryptoHack.org
import os
import random

if __name__ == '__main__':
    print("Pick two iterations to reveal, then guess the 2024th iteration!")

    indices = []
    i1 = int(input("First iteration to reveal: "))
    i2 = int(input("Second iteration to reveal: "))
    indices.append(i1)
    indices.append(i2)

    for i in range(2023):
        r = random.getrandbits(32)
        if i in indices:
            print(f'Index {i}: {r}')

    print('Enter your guess below.')
    if int(input()) == random.getrandbits(32):
        print(os.environ["FLAG"])
    else:
        print('Wrong answer, please try again.')
