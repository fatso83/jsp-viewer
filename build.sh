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
    echo "Usage:    \$0 <directory> [properties-file.txt]"
    echo
    echo "Example:  \$0 my-jsp-dir/ "
    echo
    echo "The properties file is a Java properties file and must come on the form:"
    echo "myprop=1"
    echo "your.prop=2"
    echo "These will then be set as system properties"
}
if [[ \$# < 1 ]]; then 
    echo "Missing arguments" >> /dev/stderr
    usage
    exit 1
fi

# use this shell script as a jar, as the jar file is embedded!
java -Dwebroot="\$1"  -jar "\$0" "\$2"
exit 0
EOF

    echo "Embedding the jar file into the script"
    cat $JAR >> $EXE
    chmod +x $EXE
    echo "Binary built:"
    /bin/ls -lh $EXE
}


main
