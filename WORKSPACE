workspace(name = "xyz_yannic_rules_javacc")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "bazel_toolchains",
    sha256 = "dcb58e7e5f0b4da54c6c5f8ebc65e63fcfb37414466010cf82ceff912162296e",
    strip_prefix = "bazel-toolchains-0.28.2",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-toolchains/archive/0.28.2.tar.gz",
        "https://github.com/bazelbuild/bazel-toolchains/archive/0.28.2.tar.gz",
    ],
)

load("//javacc:repositories.bzl", "rules_javacc_dependencies", "rules_javacc_toolchains")
rules_javacc_dependencies()
rules_javacc_toolchains()

load("@bazel_toolchains//rules:rbe_repo.bzl", "rbe_autoconfig")
rbe_autoconfig(name = "buildkite_config")
