module GalaxyMNISTDatasets

using MLDatasets
using DataDeps
using HDF5
using ColorTypes
using FixedPointNumbers

import MLUtils: numobs, getobs
import MLDatasets: convert2image

export GalaxyMNIST
export numobs, getobs, convert2image

include("datadeps.jl")

function __init__()
    register_datadeps()
end

struct GalaxyMNIST <: MLDatasets.SupervisedDataset
    metadata::Dict{String, Any}
    split::Symbol
    features::Array{UInt8, 4}
    targets::Vector{UInt8}
end

"""
    GalaxyMNIST(highrez=false; split=:train)

Instantiate a GalaxyMNIST dataset.  The default dataset uses low resolution
images (64x64).  A higher resolution dataset can be used by passing `true` for
postional argument `highrez`.  By default, the training dataset is used.  To use
the testing dataset, pass keyword argument `split=:test`.
"""
function GalaxyMNIST(highrez=false; split=:train)
    depname = highrez ? "GalaxyMNISTHighrez" : "GalaxyMNIST"
    filename = split == :train ? "train_dataset.hdf5" :
               split == :test  ? "test_dataset.hdf5"  :
               error("split must be :train or :test")

    datafilename = MLDatasets.datafile(depname, filename)
    features, targets = h5open(datafilename) do h5
        h5["images"][], h5["labels"][]
    end

    metadata = Dict{String, Any}(
        "n_observations" => length(targets),
        "datafile" => datafilename,
        "class_names" => ["smooth_round", "smooth_cigar",
                          "edge_on_disk", "unbarred_spiral"]
    )

    GalaxyMNIST(metadata, split, features, targets)
end

function numobs(g::GalaxyMNIST)
    length(g.targets)
end

function getobs(g::GalaxyMNIST, idx)
    (features=g.features[:,:,:,idx], targets=g.targets[idx])
end

function convert2image(::Type{GalaxyMNIST}, x::AbstractArray{UInt8,3})
    fp = reinterpret(N0f8, x)
    RGB.(eachslice(fp, dims=1)...)
end

function convert2image(t::Type{GalaxyMNIST}, x::AbstractArray{UInt8,4})
    map(o->convert2image(t, o), eachslice(x; dims=4))
end

end # module GalaxyMNISTDatasets
