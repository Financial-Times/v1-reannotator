package main

import (
	"bufio"
	b64 "encoding/base64"
	"flag"
	"fmt"
	"os"
)

var uuid *string

func main() {
	uuid = flag.String("uuid", "", "set the environment tag to use in the outputted json")
	flag.Parse()

	reader := bufio.NewReader(os.Stdin)
	text, _ := reader.ReadString('\n')
	fmt.Printf("{\"uuid\":\"%s\", \"value\":\"%s\"}", *uuid, b64.StdEncoding.EncodeToString([]byte(text)))
}
