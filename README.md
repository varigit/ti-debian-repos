# Debian-Repos

Debian-Repos is a set of scripts to build TI's Debian packages with a single
command.

## Quick instructions

To build a package, run:

```sh
./run.sh <package-name>
```

The default suite is Trixie. To build for a different suite, for example
Bookworm, set `DEB_SUITE`:

```sh
DEB_SUITE=bookworm ./run.sh <package-name>
```

The build result will be stored in:

```text
build/<suite>/<package-name>
```

The build needs to run on an ARM64 Debian-based system using the corresponding
Debian release. See the longer instructions below for details.

## Longer instructions

The generation of a Debian package involves several steps, such as obtaining
the source archive, generating and modifying Debian packaging files, preparing
the build environment, installing build dependencies, and building the source
and binary packages.

The `run.sh` script handles these steps, so building one of the supported
packages is normally as simple as running it with the desired package name.

The script needs to be executed from an ARM64 Debian-based system. This can be:

* an embedded system running the desired Debian release
* an ARM64 GitHub runner
* a cross-platform Docker container

## Using a cross-platform Docker container

This repository provides a Docker-based option for running an ARM64 Debian
environment on a non-ARM64 host.

The `Docker` directory contains:

* `Dockerfile` with the Docker image definition
* `build.sh` to build the ARM64 Docker image and install the required `binfmt`
  support

To build the default Trixie Docker image, run:

```sh
./Docker/build.sh
```

To build a Bookworm Docker image, run:

```sh
DEB_SUITE=bookworm ./Docker/build.sh
```

Start the default Trixie container with:

```sh
./start-arm64-docker
```

To start the Bookworm container, run:

```sh
DEB_SUITE=bookworm ./start-arm64-docker
```

Selecting the Docker image does not change the default suite used by `run.sh`.

For example, after starting a Bookworm container, you still need to specify
`DEB_SUITE=bookworm` when building a Bookworm package:

```sh
DEB_SUITE=bookworm ./run.sh <package-name>
```

Without `DEB_SUITE`, `run.sh` builds for Trixie by default.

The Docker images already contain the general dependencies required for
building Debian packages.

## Required Build Dependencies

There are two kinds of build dependencies:

* general build dependencies
* package-specific build dependencies

The general build dependencies are already installed in the provided Docker
images.

When using a native ARM64 Debian-based system or an ARM64 GitHub runner, the
following packages may need to be installed:

* `build-essential`
* `devscripts`
* `debhelper`
* `dpkg-dev`
* `equivs`
* `git`
* `ca-certificates`

Individual packages may require additional build dependencies. For example, a
Qt application may require additional Qt development libraries.

Package-specific build dependencies are installed automatically during the
package build and normally do not need to be installed manually.

## Information for Developers

Each supported TI package has a corresponding directory named after its Debian
source package.

The Debian packaging files are located under:

```text
<package-name>/suite/<distro-variant>/debian/
```

This directory contains files such as `control`, `rules`, man pages, and other
Debian packaging files.

Each package also contains:

```text
<package-name>/version.sh
```

This file is sourced by `run.sh` and exports variables used by the build
script.

It can also define an optional `run_prep` function. `run.sh` uses this function
for package-specific preparation before building the Debian packages.
