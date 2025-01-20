set -e

if ! [ -x "$(command -v livedown)" ]; then
    echo "livedown not found in path, installing"
    npm install -g livedown
fi
