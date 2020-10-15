module MzCore

import AxisArrays
using AxisArrays: AxisArray, Axis, axisnames, axisvalues
using AxisArrays.IntervalSets
using Unitful

export intensitytype, mztype, limits
export AxisArray, Axis, axisnames, axisvalues

# This is primarily a traits package. Format loaders should specialize methods for their supported types.
# See MzXML for a concrete example.

"""
    T = intensitytype(scan)

Return the type used to represent intentities (ion counts).

Packages should define this for the scan type, i.e.,

    MzCore.intensitytype(::Type{SomeScanType{T,...}}) = T
"""
function intensitytype end
intensitytype(scan) = intensitytype(typeof(scan))
intensitytype(S::Type) = error("intensitytype has not been specialized for type ", S)

"""
    T = mztype(scan)

Return the type used to present `m/z` values.

Packages should define this for the scan type, i.e.,

    MzCore.mztype(::Type{SomeScanType{T,...}}) = T
"""
function mztype end
mztype(scan) = mztype(typeof(scan))
mztype(S::Type) = error("mztype has not been specialized for type ", S)

"""
    axmz, axtime = limits(scans)

Return the scan-sequence limits, as an `Axis{:mz}` and `Axis{:time}`. `Axis` is from `AxisArrays`.
`axtime` should have time units (from `Unitful`), whereas `axmz` is dimensionless.
The limits should be expressed as intervals (from `IntervalSets`).
"""
function limits end

# Utilities

Unitful.ustrip(i::Interval{L,R}) where {L,R} = Interval{L,R}(ustrip(i.left), ustrip(i.right))

end
