using GalaxyMNISTDatasets
using Test

ENV["DATADEPS_ALWAYS_ACCEPT"] = true

@testset "GalaxyMNISTDatasets.jl" begin
    @testset "dataset constructor tests" begin
        tests = (
            (false, :train, (3,  64,  64, 8000)),
            (false, :test,  (3,  64,  64, 2000)),
            (true,  :train, (3, 224, 224, 8000)),
            (true,  :test,  (3, 224, 224, 2000))
        )

        for (hirez, split, sz) in tests
            @testset "GalaxyMNIST $(hirez ? "high" : "low")-res \"$(split)\" split" begin
                g = GalaxyMNIST(hirez; split)
                @test g.metadata["n_observations"] == sz[end]
                @test endswith(g.metadata["datafile"], "$(split)_dataset.hdf5")
                @test g.metadata["class_names"] == [
                    "smooth_round", "smooth_cigar", "edge_on_disk", "unbarred_spiral"
                ]
                @test g.split == split
                @test size(g.features) == sz
                @test size(g.targets) == sz[end:end]
            end
        end
    end
end
