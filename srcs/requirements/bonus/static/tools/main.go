package main

import (
	"log"
	"os"
	"path/filepath"
	"net/http"
)

func main() {
	http.Handle("/", http.FileServer(http.Dir("./static")))
	log.Fatal(http.ListenAndServeTLS(":" + os.Getenv("STATIC_PORT"),
		filepath.Join(os.Getenv("CERTS_"), "certs", os.Getenv("STATIC_DOMAIN_NAME") + ".crt"),
		filepath.Join(os.Getenv("CERTS_"), "private", os.Getenv("STATIC_DOMAIN_NAME") + ".key"), nil))
}