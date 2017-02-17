# SPICE.jl

[![Build Status](https://travis-ci.org/JuliaAstrodynamics/SPICE.jl.svg?branch=master)](https://travis-ci.org/JuliaAstrodynamics/SPICE.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/2mjf3djfw39gyl0k?svg=true)](https://ci.appveyor.com/project/JuliaAstrodynamics/spice-jl)

## Installation

On Linux and OSX CMake and a C compiler are needed.

```julia
Pkg.clone("https://github.com/JuliaAstrodynamics/SPICE.jl.git")
# Pkg.add("SPICE")
```

## Roadmap

* [X] Julia-native error handling
* [ ] Wrap the most used [CSPICE APIs](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/info/mostused.html)
* [ ] Provide julian APIs
