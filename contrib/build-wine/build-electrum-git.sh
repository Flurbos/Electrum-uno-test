#!/bin/bash

<<<<<<< HEAD
# You probably need to update only this link
ELECTRUM_GIT_URL=git://github.com/cryptapus/electrum-uno.git
BRANCH=master
NAME_ROOT=electrum-uno

=======
NAME_ROOT=electrum-uno
PYTHON_VERSION=3.5.4
>>>>>>> 743ef9ec8f1e69c56f587359f00de19f4f05ff0a

# These settings probably don't need any change
export WINEPREFIX=/opt/wine64
export PYTHONDONTWRITEBYTECODE=1
export PYTHONHASHSEED=22

PYHOME=c:/python$PYTHON_VERSION
PYTHON="wine $PYHOME/python.exe -OO -B"


# Let's begin!
cd `dirname $0`
set -e

cd tmp

for repo in electrum electrum-locale electrum-icons; do
    if [ -d $repo ]; then
	cd $repo
	git pull
	git checkout master
	cd ..
    else
	URL=https://github.com/spesmilo/$repo.git
	git clone -b master $URL $repo
    fi
done

pushd electrum-locale
for i in ./locale/*; do
    dir=$i/LC_MESSAGES
    mkdir -p $dir
    msgfmt --output-file=$dir/electrum.mo $i/electrum.po || true
done
popd

pushd electrum
if [ ! -z "$1" ]; then
    git checkout $1
fi

<<<<<<< HEAD
cd electrum-git
VERSION=`git rev-parse HEAD | awk '{ print substr($1, 0, 11) }'`
=======
VERSION=`git describe --tags`
>>>>>>> 743ef9ec8f1e69c56f587359f00de19f4f05ff0a
echo "Last commit: $VERSION"
find -exec touch -d '2000-11-11T11:11:11+00:00' {} +
popd

<<<<<<< HEAD
rm -rf $WINEPREFIX/drive_c/electrum-uno
cp -r electrum-git $WINEPREFIX/drive_c/electrum-uno
cp electrum-git/LICENCE .

# add python packages (built with make_packages)
cp -r ../../../packages $WINEPREFIX/drive_c/electrum-uno/

# add locale dir
cp -r ../../../lib/locale $WINEPREFIX/drive_c/electrum-uno/lib/

# Build Qt resources
wine $WINEPREFIX/drive_c/Python27/Lib/site-packages/PyQt4/pyrcc4.exe C:/electrum-uno/icons.qrc -o C:/electrum-uno/lib/icons_rc.py
wine $WINEPREFIX/drive_c/Python27/Lib/site-packages/PyQt4/pyrcc4.exe C:/electrum-uno/icons.qrc -o C:/electrum-uno/gui/qt/icons_rc.py
=======
rm -rf $WINEPREFIX/drive_c/electrum-uno
cp -r electrum $WINEPREFIX/drive_c/electrum-uno
cp electrum/LICENCE .
cp -r electrum-locale/locale $WINEPREFIX/drive_c/electrum-uno/lib/
cp electrum-icons/icons_rc.py $WINEPREFIX/drive_c/electrum-uno/gui/qt/

# Install frozen dependencies
$PYTHON -m pip install -r ../../requirements.txt

pushd $WINEPREFIX/drive_c/electrum-uno
$PYTHON setup.py install
popd
>>>>>>> 743ef9ec8f1e69c56f587359f00de19f4f05ff0a

cd ..

rm -rf dist/

# build standalone and portable versions
wine "C:/python$PYTHON_VERSION/scripts/pyinstaller.exe" --noconfirm --ascii --name $NAME_ROOT-$VERSION -w deterministic.spec

# set timestamps in dist, in order to make the installer reproducible
pushd dist
find -exec touch -d '2000-11-11T11:11:11+00:00' {} +
popd

# build NSIS installer
# $VERSION could be passed to the electrum.nsi script, but this would require some rewriting in the script iself.
wine "$WINEPREFIX/drive_c/Program Files (x86)/NSIS/makensis.exe" /DPRODUCT_VERSION=$VERSION electrum.nsi

cd dist
<<<<<<< HEAD
mv electrum-uno.exe $NAME_ROOT-$VERSION.exe
mv electrum-uno-setup.exe $NAME_ROOT-$VERSION-setup.exe
mv electrum-uno $NAME_ROOT-$VERSION
zip -r $NAME_ROOT-$VERSION.zip $NAME_ROOT-$VERSION
cd ..

# build portable version
cp portable.patch $WINEPREFIX/drive_c/electrum-uno
pushd $WINEPREFIX/drive_c/electrum-uno
patch < portable.patch 
popd
$PYTHON "C:/pyinstaller/pyinstaller.py" --noconfirm --ascii -w deterministic.spec
cd dist
mv electrum-uno.exe $NAME_ROOT-$VERSION-portable.exe
=======
mv electrum-setup.exe $NAME_ROOT-$VERSION-setup.exe
>>>>>>> 743ef9ec8f1e69c56f587359f00de19f4f05ff0a
cd ..

echo "Done."
md5sum dist/electrum*exe
