{
  pkgs,
  ...
}:

pkgs.writeShellApplication {
  name = "wpods";
  text = ''
    if [ -z "$1" ]; then
      echo "Error: Please provide a pod name or search term."
      echo "Usage: wpods <search_term>"
      echo "Example: wpods room"
      exit 1
    fi

    watch -d "kubectl get pods | grep \"$1\""
  '';
}
