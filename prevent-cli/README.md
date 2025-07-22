# Sentry Prevent CLI

[![codecov](https://codecov.io/gh/getsentry/prevent-cli/branch/main/graph/badge.svg)](https://codecov.io/gh/getsentry/prevent-cli)

The Sentry Prevent CLI is responsible for uploading code coverage and test results to Sentry. It can be used directly, but it is also used behind the scenes when using our [Sentry Prevent GitHub Action](https://github.com/getsentry/prevent-action).

# Usage

To upload test results to Sentry:
```
sentry-prevent-cli upload --report-type test-results
```

If your repository is not configured for tokenless uploads, you will need to set your upload token with either the PREVENT_TOKEN environment variable or by passing the --token flag at the end of your command.
