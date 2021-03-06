export xf2eul,
    xf2rav,
    xfmsta,
    xpose6,
    xpose,
    xposeg

"""
    xf2eul(xform, axisa, axisb, axisc)

Convert a state transformation matrix to Euler angles and their derivatives
with respect to a specified set of axes.

### Arguments ###

- `xform`: A state transformation matrix
- `axisa`: Axis A of the Euler angle factorization
- `axisb`: Axis B of the Euler angle factorization
- `axisc`: Axis C of the Euler angle factorization

### Output ###

Returns a tuple of an array of Euler angles and their derivatives and a boolean
that indicates whether these are a unique representation.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/xf2eul_c.html)
"""
function xf2eul(xform, axisa, axisb, axisc)
    eulang = Array{SpiceDouble}(undef, 6)
    unique = Ref{SpiceBoolean}()
    ccall((:xf2eul_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, SpiceInt, SpiceInt, SpiceInt, Ptr{SpiceDouble}, Ref{SpiceBoolean}),
          permutedims(xform), axisa, axisb, axisc, eulang, unique)
    handleerror()
    eulang, Bool(unique[])
end

"""
    xf2rav(xform)

Determines the rotation matrix and angular velocity of the rotation from a
state transformation matrix.

### Arguments ###

- `xform`: State transformation matrix

### Output ###

Returns a tuple of the rotation matrix and the angular velocity vector
associated with `xform`.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/xf2rav_c.html)
"""
function xf2rav(xform)
    rot = Array{SpiceDouble}(undef, 3, 3)
    av = Array{SpiceDouble}(undef, 3)
    ccall((:xf2rav_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, Ptr{SpiceDouble}, Ptr{SpiceDouble}),
          xform, rot, av)
    rot, av
end

"""
    xfmsta(input_state, input_coord_sys, output_coord_sys, body)

Transform a state between coordinate systems.

### Arguments ###

- `input_state`: Input state
- `input_coord_sys`: Current (input) coordinate system
- `output_coord_sys: Desired (output) coordinate system
- `body`: Name or NAIF ID of body with which coordinates are associated (if applicable)

### Output ###

Returns the converted output state.

### References ###

- [NAIF Documentation](https://naif.jpl.nasa.gov/pub/naif/toolkit_docs/C/cspice/xfmsta_c.html)
"""
function xfmsta(input_state, input_coord_sys, output_coord_sys, body)
    output_state = Array{SpiceDouble}(undef, 6)
    ccall((:xfmsta_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, Cstring, Cstring, Cstring, Ptr{SpiceDouble}),
          input_state, input_coord_sys, output_coord_sys, body, output_state)
    handleerror()
    output_state
end

function _xpose6(m)
    mout = Array{SpiceDouble}(undef, 6, 6)
    ccall((:xpose6_c, libcspice), Cvoid, (Ptr{SpiceDouble}, Ptr{SpiceDouble}), m, mout)
    mout
end

"""
    xpose6(matrix)

!!! warning "Deprecated"
    Use `transpose(matrix)` instead.
"""
xpose6

@deprecate xpose6 transpose

function _xpose(m)
    mout = Array{SpiceDouble}(undef, 3, 3)
    ccall((:xpose_c, libcspice), Cvoid, (Ptr{SpiceDouble}, Ptr{SpiceDouble}), m, mout)
    mout
end

"""
    xpose(matrix)

!!! warning "Deprecated"
    Use `transpose(matrix)` instead.
"""
xpose

@deprecate xpose transpose

function _xposeg(matrix)
    m, n = size(matrix)
    mout = Array{SpiceDouble}(undef, n, m)
    ccall((:xposeg_c, libcspice), Cvoid,
          (Ptr{SpiceDouble}, SpiceInt, SpiceInt, Ptr{SpiceDouble}), matrix, n, m, mout)
    mout
end

"""
    xposeg(matrix)

!!! warning "Deprecated"
    Use `transpose(matrix)` instead.
"""
xposeg

@deprecate xposeg transpose

