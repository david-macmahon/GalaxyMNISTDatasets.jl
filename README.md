# GalaxyMNISTDatasets

This package provides a Julia interface to the [GalaxyMNIST datasets](
https://github.com/mwalmsley/galaxy_mnist) that is compatible with
[MLDatasets.jl](https://juliaml.github.io/MLDatasets.jl/stable/).

![image](docs/images/mosaic200.png)

If you use one of these datasets, please cite [Galaxy Zoo
DECaLS](https://ui.adsabs.harvard.edu/abs/2022MNRAS.509.3966W/abstract),
the data release paper from which the labels are drawn. Please also
acknowledge the DECaLS survey (see the linked paper for an example).

## Introduction

These datasets contain 10,000 images of galaxies (3x64x64 or 3x224x224),
confidently labelled by Galaxy Zoo volunteers as belonging to one of four
morphology classes:

### smooth_round
![image](docs/images/smooth_round.png)

### smooth_cigar

![image](docs/images/smooth_cigar.png)

### edge_on_disk

![image](docs/images/edge_on_disk.png)

### unbarred_spiral

![image](docs/images/unbarred_spiral.png)

## Installation

Use `Pkg` to install this package from Julia:

```julia
import Pkg
Pkg.add("GalaxyMNIST")
```

Alternatively, the "package manager" interface of the REPL can be used:

```julia
julia> ]
(@v1.8) pkg> add  GalaxyMNISTDataSets
```

## Usage

This package can be used like one of the MLDatasets.jl datasets.  See the
[MLDatasets.jl](https://juliaml.github.io/MLDatasets.jl/stable/) documentation
for more details.

The `GalaxyMNIST` constructor is used to instantiate a dataset:

    GalaxyMNIST(highrez=false; split=:train)

The default dataset uses low resolution images (64x64).  A higher resolution
(224x224) dataset can be used by passing `true` for postional argument
`highrez`.  By default, the training dataset is used.  To use the testing
dataset, pass keyword argument `split=:test`.

The first time each user references the low resolultion or high resolution
dataset, the source data files containing the training and testing data for that
resolution will be downloaded.  This involves an informational message that
prompts for confirmation before downlaoding.  To avoid the message and the
prompt, set `ENV["DATADEPS_ALWAYS_ACCEPT"] = true` before calling `GalaxyMNIST`
for the first time.  The downloaded files will be saved for future use.

## Example

Here is a simple example:

```julia
julia> using GalaxyMNISTDatasets, MosaicViews, ImageShow

julia> galdata = GalaxyMNIST()
dataset GalaxyMNIST:
  metadata  =>    Dict{String, Any} with 3 entries
  split     =>    :train
  features  =>    3×64×64×8000 Array{UInt8, 4}
  targets   =>    8000-element Vector{UInt8}
 
julia> galdata.metadata
Dict{String, Any} with 3 entries:
  "n_observations" => 8000
  "class_names"    => ["smooth_round", "smooth_cigar", "edge_on_disk", "unbarred_spiral"]
  "datafile"       => "/Users/davidm/.julia/datadeps/GalaxyMNIST/train_dataset.hdf5"


julia> mosaic(convert2image(galdata, 1:96), nrow=8)
```

![image](docs/images/mosaic96.png)
