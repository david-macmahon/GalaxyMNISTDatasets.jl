import MD5: md5

"""
    register_datadeps()

Registers `GalaxyMNIST` and `GalaxyMNISTHighrez` as data dependencies.  This
will make the following four files available:

- `datadep"GalaxyMNIST/train_dataset.hdf5"`
- `datadep"GalaxyMNIST/test_dataset.hdf5"`
- `datadep"GalaxyMNISTHighrez/train_dataset.hdf5"`
- `datadep"GalaxyMNISTHighrez/test_dataset.hdf5"`

The files will not be downloaded until first referenced.  The first reference of
one of these files will download both files of that file's data dependency.

This function is called by GalaxyMNIST.__init__().  It need/should not be called
directly.
"""
function register_datadeps()
    register(DataDep(
        "GalaxyMNIST",
        """
        Contains `train_dataset.hdf5` and `test_dataset.hdf5` files comprising
        the [`galaxy_mnist`](https://github.com/mwalmsley/galaxy_mnist) dataset.
        These files contain 10,000 images of galaxies (3x64x64), confidently
        labelled by Galaxy Zoo volunteers as belonging to one of four morphology
        classes.

        If you use this dataset, please cite [Galaxy Zoo
        DECaLS](https://ui.adsabs.harvard.edu/abs/2022MNRAS.509.3966W/abstract),
        the data release paper from which the labels are drawn. Please also
        acknowledge the DECaLS survey (see the linked paper for an example).
        """,
        "https://dl.dropboxusercontent.com/s/" .* [
            "5a14de0o7slyif9/train_dataset.hdf5.gz",
            "5rza12nn24cwd2k/test_dataset.hdf5.gz"
        ],
        [
            (md5, "e408ae294e9b975482dc1abffeb373a6"),
            (md5, "7a940e4cea64a8b7cb60339098f74490")
        ];
        post_fetch_method = unpack
    ))

    register(DataDep(
        "GalaxyMNISTHighrez",
        """
        Contains `train_dataset.hdf5` and `test_dataset.hdf5` files comprising
        the [`galaxy_mnist`](https://github.com/mwalmsley/galaxy_mnist) dataset.
        These files contain 10,000 images of galaxies (3x224x224), confidently
        labelled by Galaxy Zoo volunteers as belonging to one of four morphology
        classes.

        If you use this dataset, please cite [Galaxy Zoo
        DECaLS](https://ui.adsabs.harvard.edu/abs/2022MNRAS.509.3966W/abstract),
        the data release paper from which the labels are drawn. Please also
        acknowledge the DECaLS survey (see the linked paper for an example).
        """,
        "https://dl.dropboxusercontent.com/s/" .* [
            "xenuo0ekgyi10ru/train_dataset.hdf5.gz",
            "lczri4sb4bbcgyh/test_dataset.hdf5.gz"
        ],
        [
            (md5, "3391dcddac14d5b4055db73fb600ae63"),
            (md5, "fb272c4e94000b4d99a09d638977b0b9")
        ];
        post_fetch_method = unpack
    ))
end
