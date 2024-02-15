# Script to create users for High School CTF
import requests
import random


def main():
    url = "https://hsctf.netsoc.ca/"
    with open('ctfd.key', 'r') as f:
        CTFD_TOKEN = f.read()

    word_list = [
        'apple', 'banana', 'cherry', 'date', 'elderberry', 'fig', 'grape', 'honeydew', 'kiwi', 'lemon',
        'mango', 'nectarine', 'orange', 'papaya', 'quince', 'raspberry', 'strawberry', 'tangerine', 'ugli',
        'watermelon', 'avocado', 'blueberry', 'cantaloupe', 'dragonfruit', 'elderberry', 'fig', 'grapefruit',
        'huckleberry', 'jackfruit',
        'kiwi', 'lemon', 'mango', 'nectarine', 'olive', 'persimmon', 'quince', 'raisin', 'strawberry', 'tangerine',
        'ugli', 'vanilla', 'watermelon', 'apricot', 'blueberry', 'coconut', 'durian', 'elderberry', 'fig', 'grape',
        'huckleberry', 'jackfruit', 'kiwi', 'lemon', 'mango', 'nectarine', 'olive', 'papaya', 'quince', 'raspberry',
        'strawberry', 'tangerine', 'ugli', 'watermelon', 'apricot', 'blueberry', 'coconut', 'durian', 'elderberry',
        'fig',
        'grapefruit', 'huckleberry', 'jackfruit', 'kiwi', 'lemon', 'mango', 'nectarine', 'olive', 'persimmon', 'quince',
        'raisin', 'strawberry', 'tangerine', 'ugli', 'vanilla', 'watermelon', 'apricot', 'blueberry', 'coconut',
        'durian',
        'elderberry', 'fig', 'grapefruit', 'huckleberry', 'jackfruit', 'kiwi', 'lemon', 'mango', 'nectarine', 'olive',
        'persimmon', 'quince', 'raisin', 'strawberry', 'tangerine', 'ugli', 'vanilla', 'watermelon', 'apricot',
        'blueberry',
        'coconut', 'durian', 'elderberry', 'fig', 'grapefruit', 'huckleberry', 'jackfruit', 'kiwi', 'lemon', 'mango',
        'nectarine', 'olive', 'papaya', 'quince', 'raspberry', 'strawberry', 'tangerine', 'ugli', 'watermelon',
        'apricot',
        'blueberry', 'coconut', 'durian', 'elderberry', 'fig', 'grapefruit', 'huckleberry', 'jackfruit', 'kiwi',
        'lemon',
        'mango', 'nectarine', 'olive', 'persimmon', 'quince', 'raisin', 'strawberry', 'tangerine', 'ugli', 'vanilla',
        'watermelon', 'apricot', 'blueberry', 'coconut', 'durian', 'elderberry', 'fig', 'grapefruit', 'huckleberry',
        'jackfruit',
        'kiwi', 'lemon', 'mango', 'nectarine', 'olive', 'persimmon', 'quince', 'raisin', 'strawberry', 'tangerine',
        'ugli', 'vanilla', 'watermelon', 'apricot', 'blueberry', 'coconut', 'durian', 'elderberry', 'fig', 'grapefruit',
        'huckleberry', 'jackfruit', 'kiwi', 'lemon', 'mango', 'nectarine', 'olive', 'papaya', 'quince', 'raspberry',
        'strawberry', 'tangerine', 'ugli', 'watermelon', 'apricot', 'blueberry', 'coconut', 'durian', 'elderberry',
        'fig',
        'grapefruit', 'huckleberry', 'jackfruit', 'kiwi', 'lemon', 'mango', 'nectarine', 'olive', 'persimmon', 'quince',
        'raisin', 'strawberry', 'tangerine', 'ugli', 'vanilla', 'watermelon', 'apricot', 'blueberry', 'coconut',
        'durian',
        'elderberry', 'fig', 'grapefruit', 'huckleberry', 'jackfruit', 'kiwi', 'lemon', 'mango', 'nectarine', 'olive',
        'persimmon', 'quince', 'raisin', 'strawberry', 'tangerine', 'ugli', 'vanilla', 'watermelon'
    ]
    used_passwords = []

    # Create API Session
    url = url.strip("/")
    s = requests.Session()
    s.headers.update({"Authorization": f"Token {CTFD_TOKEN}"})
    creds = []
    for i in range(200):
        user = f"user{i}"
        while True:
            passw = f"{random.choice(word_list)}-{random.choice(word_list)}"
            if passw not in used_passwords:
                used_passwords.append(passw)
                break

        creds.append((user, passw))
        r = s.post(
            f"{url}/api/v1/users",
            json={"name": user,"password": passw,"type":"user","verified":False,"hidden":False,"banned":False,"fields":[]},
            headers={"Content-Type": "application/json"},
        )
        print(r.json())

    with open('hsctf_creds', 'w') as file:
        for cred in creds:
            file.write(cred[0])
            file.write(' - ' + cred[1] + '\n')


if __name__ == "__main__":
    main()
