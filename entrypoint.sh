#!/bin/sh
set -e

# Optionally load a key left in .github for us
if [ -f .github/signing_key ]; then
    gpg --import .github/signing_key
fi

# Set the install command to be used by mk-build-deps (use --yes for non-interactive)
install_tool="apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends --yes"
# Install build dependencies automatically
mk-build-deps --install --tool="${install_tool}" --remove debian/control
# Build the package
gbp buildpackage
# Output the filename
cd ..
filename=`ls *.deb | grep -v -- -dbgsym`
dbgsym=`ls *.deb | grep -- -dbgsym`
echo ::set-output name=filename::$filename
echo ::set-output name=filename-dbgsym::$dbgsym
# Move the built package into the Docker mounted workspace
mv $filename $dbgsym workspace/
