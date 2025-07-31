# Sentry Prevent CLI

[![codecov](https://codecov.io/gh/getsentry/prevent-cli/branch/main/graph/badge.svg)](https://codecov.io/gh/getsentry/prevent-cli)

The Sentry Prevent CLI is responsible for uploading code coverage and test results to Sentry. It can be used directly or indirectly through our [Sentry Prevent GitHub Action](https://github.com/getsentry/prevent-action).

> [!NOTE]  
> The Codecov CLI is still around! We have moved the Codecov CLI's codebase into the `codecov-cli` sub-project in this repository because the Sentry Prevent CLI uses it as a backend and we wanted to keep the projects together in the `getsentry` organization. The Codecov CLI is still being maintained, improved, and published - just from this repository. See the sub-project's [README](/codecov-cli/README.md) for Codecov CLI specific information, the rest of this document will be about the Prevent CLI.

- [Installing](#installing)
- [Usage](#usage)
- [Contributions](#contributions)
- [Releases](#releases)

# Installing

### PyPI

```
pip install sentry-prevent-cli
```

### Binary

We build and publish binaries for Linux, MacOS, and Windows. See our GitHub Releases for the full list of OS/architecture combos we build for. We'll use our macos binary for demonstration purposes here:
```
curl -o sentry-prevent-cli -L "https://github.com/getsentry/prevent-cli/releases/latest/download/sentry-prevent-cli_macos"
chmod +x sentry-prevent-cli
```

#### Verifying the binary
If you'd like, you may use Sigstore's Cosign to verify the integrity of your download against our provided Cosign bundles and identity details. For more information on Cosign along with installation instructions, see their [documentation](https://docs.sigstore.dev/cosign/system_config/installation).

First get the appropriate Cosign bundle from our GitHub Release assets. Appending `.bundle` to the binary URL will get you the right file.
```
curl -O -L "https://github.com/getsentry/prevent-cli/releases/latest/download/sentry-prevent-cli_macos.bundle"
```
Then, use `cosign` to verify the binary:
```
cosign verify-blob sentry-prevent-cli --bundle sentry-prevent-cli_macos.bundle --certificate-identity-regexp=^https://github.com/getsentry/prevent-cli --certificate-oidc-issuer=https://token.actions.githubusercontent.com
```
The OIDC identity here is associated with the specific workflow run that signs the binary. If this command says the binary is verified, you can trust you've recieved the same binary we built in our GitHub Actions workflow.

# Usage

Todo

# Contributions

Todo

# Releases

Todo
