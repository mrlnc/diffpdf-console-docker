# diffpdf-console-docker

`diffpdf` is a GUI tool to compare PDF files. It has the option to create an output PDF containing both source files with differences highlighted.

The tool lacks a command-line interface, rendering batch-processing difficult. There's a patch to add a command line argument for automatic creation of an output file: https://github.com/taurus-forever/diffpdf-console

I'm just providing a Dockerfile here, combining the Ubuntu/Debian patches and the one from `taurus-forever/diffpdf-console`. Hope it saves you some time reading through the build instructions.

The same already exists -- didn't realize until done: https://github.com/amitev/diffpdf-console-docker

# Build

```
docker build -t diffpdf-console-docker .
```

# Run

```
host$ ls /home/merlin/pdf
old.pdf new.pdf
host$ docker run --rm -v /home/merlin/pdf:/root/pdf diffpdf-console-docker /root/pdf/old.pdf /root/pdf/new.pdf /root/pdf/diff.pdf
host$ ls /home/merlin/pdf
old.pdf new.pdf diff.pdf
```