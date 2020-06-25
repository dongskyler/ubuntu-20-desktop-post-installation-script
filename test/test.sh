main() {
  printf "Beginning of test.sh\n"

  for f in ./lib/*.sh; do
    printf "%s\n" "$f"
    source $f
  done

  test_lib
  
  printf "End of test.sh\n"
}

main "$@"
