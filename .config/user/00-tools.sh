md() {
    pandoc "$1" | lynx -stdin
}
