#!/bin/sh
# This setup will build a self-contained executable that can be invoked on its own

JAR=./target/jspviewer-1-SNAPSHOT-jar-with-dependencies.jar

main(){
    build_jar
    create_exe
}

build_jar(){
    # gathers all dependencies and builds the thing
    # http://stackoverflow.com/a/574650/200987
    mvn install
}


create_exe(){
    EXE=view-jsp
    cat > $EXE << EOF  
#!/bin/sh
function usage(){
    echo "Usage:    \$0 <directory> [port]"
    echo
    echo "Example:  \$0 my-jsp-dir/ 8000"
    echo
    echo "The default port is 8080"
}
if [[ \$# < 1 ]]; then 
    echo "Missing arguments \$#" >> /dev/stderr
    usage
    exit 1
fi

# use this shell script as a jar, as the jar file is embedded!
java -Dwebroot="\$1" -Dport="\$2"  -jar "\$0"
exit 0
EOF

    echo "Embedding the jar file into the script"
    cat $JAR >> $EXE
    chmod +x $EXE
    echo "Binary built:"
    /bin/ls -lh $EXE
}


main
