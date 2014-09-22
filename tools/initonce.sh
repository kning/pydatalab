#!/bin/sh

# Script to initialize a dev workstation. Installs required packages/tools.

# Python package manager installation
# This is the approach recommended by PyPI
pip_dir='/tmp/pip-install';
script_path=${pip_dir}/git-pip.py;
if which pip >/dev/null; then
  echo "Installing pip...";
  mkdir -p $pip_dir &&
  curl https://bootstrap.pypa.io/get-pip.py > ${script_path} &&
  python ${script_path};
fi

# Python Linter (http://www.pylint.org)
pip install pylint

# Node.js check
if which node >/dev/null; then
  echo "NodeJS installed"
else
  echo "Please install NodeJS 0.10.x: http://nodejs.org/download"
fi

# Gradle 2.0 check
if which gradle >/dev/null; then  
  gradle_version=`gradle -version | grep Gradle | cut -f2 -d' '`
  gradle_major_version=`echo $gradle_version | cut -f1 -d.`
  if [ "$gradle_major_version" != "2" ]; then
    echo "Please install Gradle 2.x"
  fi
  echo "Found Gradle version '${gradle_version}'"
else  
  echo "Please install Gradle 2.0: http://www.gradle.org/downloads"
fi

# TypeScript compiler
if which npm >/dev/null; then  
  npm install -g typescript
else
  echo "Please install NodeJS and then re-run this script to install the TypeScript compiler."
fi
