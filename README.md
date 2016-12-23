Simple JSP viewer
======================================

> Serve JSPs in an easy way for quick-editing

## Why 
Sometimes front-enders need to edit jsps without having 
access to the actual application server to test it out.
This enables us to see the result, and also reference
any system properties needed by setting them in a 
properties file.

## Usage
`view-jsp ./jsp-dir my-properties.txt`

This will fire up a server on port 8080 on localhost that
will display the jsp. You need to have `java` on the path.

## Getting the executable
Either grab the executable from the [releases page](https://github.com/fatso83/jsp-viewer/releases),
 or build it yourself after cloning this repo.

Just issue `./build` to end up with the executable `view-jsp`.

## Dependencies
- For running: only Java (I think Java 7 will do)
- For building: Maven 3
