Simpe JSP viewer
======================================

A very focused tool that does one thing: it serves JSPs
and can set system properties used in that jsp from a 
properties file.

## Usage
`view-jsp ./jsp-dir my-properties.txt`

This will fire up a server on port 8080 on localhost that
will display the jsp. You need to have `java` on the path.

## Build
Just issue `./build` to end up with a executable `view-jsp`.

## Dependencies
- For running: only Java (I think Java 7 will do)
- For building: Maven 3
