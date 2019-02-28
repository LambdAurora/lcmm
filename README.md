# LambdaCMakeModules (lcmm)

![C++](https://img.shields.io/badge/language-CMake-9B599A.svg?style=flat-square)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/LambdAurora/lcmm/master/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/LambdAurora/lcmm.svg?style=flat-square)](https://github.com/LambdAurora/lcmm/issues/)

LambdaCMakeModules is a project which contains a lot of CMake scripts to make developer's life easier in C/C++ development.
LCMM provides scripts to find various libraries, easier compilation and installation generation script.

## How to use?

It is recommended to use the Git's submodule subsystem to import these scripts, in your git root just execute:
```sh
git submodule add https://github.com/LambdAurora/lcmm.git cmake
```

When the scripts are cloned into the `cmake` directory, add the following code to your `CMakeLists.txt`:
```cmake
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
```
Now you can use these scripts in your project.
