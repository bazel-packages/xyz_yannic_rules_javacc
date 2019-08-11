# JavaCC Rules for [Bazel](https://bazel.build)

This repository contains Starlark implementation of JavaCC rules in Bazel.

## Getting Started

To get started with `rules_javacc`, add the following to your `WORKSPACE` file:

```python
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_javacc",
    strip_prefix = "rules_javacc-master",
    urls = [
        "https://github.com/Yannic/rules_javacc/archive/master.tar.gz",
    ],
)
load("@rules_javacc//javacc:repositories.bzl", "rules_javacc_dependencies", "rules_javacc_toolchains")
rules_javacc_dependencies()
rules_javacc_toolchains()
```

Then, in your `BUILD` files, import and use the rules:

```python
load("@rules_javacc//javacc:defs.bzl", "javacc_library")

javacc_java_library(
    ...
)
```

## Contributing

Bazel and `rules_javacc` are the work of many contributors.
We appreciate your help!
