using MzCore
using MzCore.IntervalSets
using Unitful
using AxisArrays: Axis, axisvalues
using Test

module MzFormat
    using MzCore
    using MzCore.IntervalSets
    using AxisArrays: Axis, axisvalues
    using Unitful

    export MyScan

    struct MyScan{TI,Tmz}
        mzmin::Tmz
        mzmax::Tmz
        time::typeof(1.0u"s")
    end
    MyScan{TI}(mzmin::Tmz, mzmax::Tmz, time) where {TI,Tmz} = MyScan{TI,Tmz}(mzmin, mzmax, time)

    MzCore.intensitytype(::Type{MyScan{TI,Tmz}}) where {TI,Tmz} = TI
    MzCore.mztype(::Type{MyScan{TI,Tmz}})        where {TI,Tmz} = Tmz

    function MzCore.limits(scans::AbstractVector{<:MyScan})
        Axis{:mz}(scans[1].mzmin .. scans[1].mzmax), Axis{:time}(minimum(s->s.time, scans) .. maximum(s->s.time, scans))
    end
end

using .MzFormat

@testset "MzCore.jl" begin
    # These eltypes would never be used in practice, but they are good for testing
    scans = [MyScan{Int16}(Float16(80), Float16(1000), 3.2u"s"), MyScan{Int16}(Float16(80), Float16(1000), 5.8u"s")]
    @test intensitytype(scans[1]) === Int16
    @test mztype(scans[1]) === Float16
    axmz, axtime = limits(scans)
    @test axisvalues(axmz)[1] == Float16(80) .. Float16(1000)
    @test ustrip(axisvalues(axtime)[1]) == 3.2 .. 5.8
end
