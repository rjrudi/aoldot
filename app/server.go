package main

import (
  "os"
  "fmt"
  "io/ioutil"
  "log"
  "net/http"
  "time"
)

func appHandler(w http.ResponseWriter, r *http.Request) {
  //resp, err := http.Get("http://169.254.169.254/latest/meta-data/instance-id")
  resp, err := http.Get("http://www.worldtimeserver.com/")

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
  fmt.Fprintln(w, time.Now(), "\n\n" + "Revision D\n\n" + string(instID))
}

func main() {
  http.HandleFunc("/", appHandler)
  log.Println("Started, serving on port " + os.Args[1])
  err := http.ListenAndServe(":" + os.Args[1], nil)
  if err != nil {
    log.Print(err.Error())
  }
}
