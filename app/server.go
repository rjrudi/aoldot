package main

import (
  "fmt"
  "io/ioutil"
  "log"
  "net/http"
  "time"
)

func appHandler(w http.ResponseWriter, r *http.Request) {
  //resp, err := http.Get("http://169.254.169.254/latest/meta-data/instance-id")
  //resp, err := http.Get("http://www.aol.com")
  resp, err := http.Get("http://www.aol.com")

  if err != nil {
    fmt.Fprintln(w, err)
    log.Print(err)
  }

  instID, err := ioutil.ReadAll(resp.Body)

  if err != nil {
    fmt.Fprintln(w, err)
    log.Print(err)
  }

  defer resp.Body.Close()
  fmt.Fprintln(w, time.Now(), string(instID))
}

func main() {
  http.HandleFunc("/", appHandler)

  log.Println("Started, serving on port 8080")
  err := http.ListenAndServe(":8080", nil)

  if err != nil {
    log.Print(err.Error())
  }
}
