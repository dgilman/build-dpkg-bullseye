#!/bin/sh
set -e

# Load a key for signing dsc etc
gpg --import .github/signing_key

# Set the install command to be used by mk-build-deps (use --yes for non-interactive)
install_tool="apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends --yes"
# Install build dependencies automatically
mk-build-deps --install --tool="${install_tool}" --remove debian/control
# Remove when https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=989696 is fixed
rm *.buildinfo *.changes
# Build the package
gbp buildpackage
echo "Done building package"

# Move build contents to dist/ dir
mkdir -p dist
find .. -maxdepth 1 -type f -print0 | xargs -0 -I {} mv {} dist
ls -alh dist
