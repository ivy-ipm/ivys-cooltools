#!/data/data/com.termux/files/usr/bin/bash

USER="ivy-ipm"
BASE="$HOME/.ivy"
PKG="$BASE/pkgs.txt"
OPENXR="$BASE/pkgs/openxr"

mkdir -p "$BASE/pkgs"
touch "$PKG"

echo "IVY ENGINE v1 ($USER)"

cmd="$1"

case "$cmd" in

h)
echo "ivy init <name>"
echo "ivy run <file>"
echo "ivy compile <file> <out>"
echo "ivy openxr"
echo "ivy pkgs add <name>"
echo "ivy pkgs edit"
echo "ivy store install <git> <name>"
;;

init)
mkdir -p "$2"
echo "main.cpp" > "$2/project.ivy"
cat > "$2/main.cpp" <<EOF
#include <iostream>
int main(){ std::cout<<"IVY READY\n"; }
EOF
;;

run)
clang++ "$2" -o /data/data/com.termux/files/usr/tmp/ivy_run
/data/data/com.termux/files/usr/tmp/ivy_run
;;

compile)
in="$2"
out="$3"

flags=""

while read p; do
[ -z "$p" ] && continue
flags="$flags -I$BASE/pkgs/$p/include -L$BASE/pkgs/$p/lib"
done < "$PKG"

flags="$flags -lvulkan"

clang++ "$in" $flags -shared -fPIC -o "$out"
;;

openxr)
if [ ! -d "$OPENXR" ]; then
git clone https://github.com/KhronosGroup/OpenXR-SDK.git "$OPENXR"
fi

cd "$OPENXR"

cmake -B build -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX="$OPENXR/install"

cmake --build build
cmake --install build
;;

pkgs)
case "$2" in
add)
echo "$3" >> "$PKG"
;;
edit)
nano "$PKG"
;;
*)
cat "$PKG"
;;
esac
;;

store)
git clone "$3" "$BASE/pkgs/$4"
;;

*)
echo "ivy h"
;;

esac
