#!/bin/sh
# This setup will build a self-contained executable that can be invoked on its own

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
JAR="$SCRIPT_DIR/target/jspviewer-1-SNAPSHOT-jar-with-dependencies.jar"

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
    echo "Usage:    \$0 <directory> [session-props.txt [system-props.txt]]`
    echo
    echo "Example:  \$0 my-jsp-dir/ "
    echo
    echo "The properties file(s) is a Java properties file and must come on the form:"
    echo "myprop=1"
    echo "your.prop=2"
    echo "These will then be set as system properties"
}

if [[ \$# < 1 ]]; then 
    echo "Missing arguments" >> /dev/stderr
    usage
    exit 1
fi

WEBROOT="\$1"

[[ x\$PORT == x ]] && PORT=9000

# shift arguments by 1 (meaning drop the first)
shift

# use this shell script as a jar, as the jar file is embedded!
#java    -Dtomcat.util.scan.StandardJarScanFilter.jarsToScan="taglibs-standard-impl-*"     -Dtomcat.util.scan.StandardJarScanFilter.jarsToSkip="apache-*,ecj-*,jetty-*,asm-*,javax.servlet-*,javax.annotation-*,taglibs-standard-spec-*"  -Dwebroot="\$1" -jar "\$0"

# temporary fix until I can sort out https://github.com/fatso83/jsp-viewer/issues/1
java    -Dtomcat.util.scan.StandardJarScanFilter.jarsToScan="taglibs-standard-impl-*"     \\
        -Dport="\$PORT" \
        -Dtomcat.util.scan.StandardJarScanFilter.jarsToSkip="apache-*,ecj-*,jetty-*,asm-*,javax.servlet-*,javax.annotation-*,taglibs-standard-spec-*"  \\
        -Dwebroot="\$WEBROOT" -jar "$JAR" "\$@"

exit 0
EOF

    # temporary fix until I can sort out https://github.com/fatso83/jsp-viewer/issues/1
    #echo "Embedding the jar file into the script"
    #cat $JAR >> $EXE
    chmod +x $EXE
    echo "Binary built:"
    /bin/ls -lh $EXE
}


main
