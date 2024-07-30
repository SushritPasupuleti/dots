package main

import (
    "fmt"
    "os/exec"
)

func main() {

    cmd := exec.Command("pwd")
    stdout, err := cmd.Output()

    if err != nil {
        fmt.Println(err.Error())
        return
    }

    // Print the output
    fmt.Println(string(stdout))
}
