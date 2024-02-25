#!/bin/bash
apt update

level1() {
    groupadd -g 1111 level1
    useradd -m -s /bin/bash -u 1111 -g 1111 level1
    echo 'level1:Sizzle-Resend-Scarecrow' | chpasswd 
    echo 'th1s_fe3ls_fam1li4r' > /home/level1/.flag
    chmod -R ug=r /home/level1
    chmod ug=rx /home/level1
}
level2() {
    groupadd -g 2222 level2
    useradd -m -s /bin/bash -u 2222 -g 2222 level2
    echo 'level2:th1s_fe3ls_fam1li4r' | chpasswd

    cd /home/level2
    createABunchOfFiles
    echo "f1ndm3f1ndm3" > dir60/subdir40/file77.txt
    
    chmod -R ug=r /home/level2
    chmod ug=rx /home/level2
    chmod u=rx dir60/subdir40/file77.txt
}
level3() {
    groupadd -g 3333 level3
    useradd -m -s /bin/bash -u 3333 -g 3333 level3
    echo 'level3:f1ndm3f1ndm3' | chpasswd

    cd /home/level3
    createABunchOfFiles

    chown 123:321 dir25/subdir90/file4.txt
    echo "1d3nt1f13rs" > dir25/subdir90/file4.txt

    chmod -R ug=r /home/level3
    chmod ug=rx /home/level3
}
level4() {
    groupadd -g 4444 level4
    useradd -m -s /bin/bash -u 4444 -g 4444 level4
    echo 'level4:1d3nt1f13rs' | chpasswd

    dd if=/dev/urandom bs="10000000" count=1 status=none > /tmp/random
    sed "20000s/$/RobotsCantReadMe/" /tmp/random > /home/level4/random.txt
    chmod -R ug=r /home/level4
    chmod ug=rx /home/level4
}
level5() {
    groupadd -g 5555 level5
    useradd -m -s /bin/bash -u 5555 -g 5555 level5
    echo 'level5:RobotsCantReadMe' | chpasswd

    file_size=$((10*1024*1024))  # 10 MB
    line="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."

    # Calculate the number of times the line should be duplicated to reach the desired file size
    line_count=$((file_size / ${#line} + 1))

    # Create the file by duplicating the line
    for ((i=0; i<line_count; i++)); do
                echo "$line"
    done > /tmp/random2
    sed "64230s/$/un1que_n3wy0rk/" /tmp/random2 > /home/level5/random.txt
    chmod -R ug=r /home/level5
    chmod ug=rx /home/level5
}
level6() {
    groupadd -g 6666 level6
    useradd -m -s /bin/bash -u 6666 -g 6666 level6
    echo 'level6:un1que_n3wy0rk' | chpasswd

    echo "z1ppedUp7ight" > /tmp/flag.txt
    apt install -y bzip2 p7zip-full zip
    tar -czf /tmp/flag.tar.gz /tmp/flag.txt
    tar -cjf /tmp/flag.tar.gz.bz2 /tmp/flag.tar.gz
    zip /tmp/flag.tar.gz.bz2.zip /tmp/flag.tar.gz.bz2
    7z a /home/level6/flag.tar.gz.bz2.zip.7z /tmp/flag.tar.gz.bz2.zip

    chmod -R ug=r /home/level6
    chmod ug=rx /home/level6
}

level7() {
    groupadd -g 7777 level7
    useradd -m -s /bin/bash -u 7777 -g 7777 level7
    echo 'level7:z1ppedUp7ight' | chpasswd

    cd /home/level7
    wget https://en.wikipedia.org/wiki/List_of_Glagolitic_manuscripts
    mv List_of_Glagolitic_manuscripts file1.txt
    sed "36363s/$/d1ff3rEnc3s/" /home/level7/file1.txt > /home/level7/file2.txt
    chmod -R ug=r /home/level7
    chmod ug=rx /home/level7
}

level8() {
    groupadd -g 8888 level8
    useradd -m -s /bin/bash -u 8888 -g 8888 level8
    echo 'level8:d1ff3rEnc3s' | chpasswd

    echo "3xtend0" > /home/level8/flag.pcap
    printf '\xd4\xc3\xb2\xa1' | dd conv=notrunc of=/home/level8/flag.pcap bs=1 seek=0

    # make this level the 'totally-real-program.exe' level (use `find` to discover the file type)
    # (thinking about it now though, they won't have a way to view the QR code, so gonna have to use a different file)
    # make next level the grep challenge - out.txt too big for github so just recreate file in the script
    chmod -R ug=rx /home/level8

}
level9() {
    groupadd -g 9999 level 9
    useradd -m -s /bin/bash -u 9999 -g 9999 level9
    echo 'level9:3xtend0' | chpasswd 

    curl -o /home/level9/out.txt https://file.io/zO2L6xJoXqSj
    chmod -R ug=rx /home/level8
}

level10() {
    groupadd -g 1110 level11
    groupadd -g 1100 level10
    useradd -m -s /bin/bash -u 1110 -g 1110 level11
    useradd -m -s /bin/bash -u 1100 -g 1100 level10
    echo 'level11:' | chpasswd

    apt install -y vim
    cp $(which vim) /home/level10/vim

    chown level11:level11 /home/level10/vim
    
    chmod -R ugo=rx /home/level10
    chmod ug=rx /home/level10 
    
    chmod u+s /home/level10/vim

    # PoC: ./vim -c ':py3 import os; os.execl("/bin/sh", "sh", "-pc", "reset; exec sh -p")'
}


createABunchOfFiles() {
    # Create 100 txt files
    for ((i=1; i<=100; i++)); do
        touch "file$i.txt"
    done
    # Move them all to subdir1
    mkdir "subdir1" && mv *.txt subdir1/
    # Create 100 copies
    for ((j=2; j<=100; j++)); do
        cp -r subdir1 "subdir$j"
    done
    # Move these to new parent dir
    mkdir "dir1" && mv subdir* dir1/
    # Create 100 copies
    for ((k=2; k<=100; k++)); do
        cp -r dir1 "dir$k"
    done
}

level1
level2
level3
level4
level5
level6
level7
level8
level9

chmod ugo=wx /tmp
