def even_or_odd(number):
    answer = ""
    if number % 2 == 0:
        answer = "even"
    else:
        answer = "odd"
    return answer


def main():
    with open('input.txt') as f:
        lines = f.readlines()

    for line in lines:
        a = even_or_odd(int(line))
        print(a)


main()