# Copyright 2019 The Rules JavaCC Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load("@bazel_tools//tools/jdk:toolchain_utils.bzl", "find_java_runtime_toolchain", "find_java_toolchain")

def _split_srcs(srcs):
    javacc_srcs = []
    other_srcs = []

    for src in srcs:
        if src.basename.endswith(".jj"):
            javacc_srcs.append(src)
        else:
            other_srcs.append(src)

    return javacc_srcs, other_srcs

def _javacc_java(actions, toolchain, output, input):
    args = actions.args()

    args.add("-OUTPUT_SRCJAR={}".format(output.path))
    args.add(input.path)

    actions.run(
        executable = toolchain.javacc,
        inputs = [input],
        outputs = [output],
        arguments = [args],
    )

def _javacc_java_library_impl(ctx):
    javacc_srcs, java_srcs = _split_srcs(ctx.files.srcs)

    srcjars = []
    for javacc_src in javacc_srcs:
        srcjar = ctx.actions.declare_file(
            "{}.srcjar".format(javacc_src.basename[:-3]),
        )
        _javacc_java(
            actions = ctx.actions,
            toolchain = struct(
                javacc = ctx.executable._javacc,
            ),
            output = srcjar,
            input = javacc_src,
        )
        srcjars.append(srcjar)

    jar = ctx.actions.declare_file("{}.jar".format(ctx.attr.name))
    srcjar = ctx.actions.declare_file("{}.srcjar".format(ctx.attr.name))
    return [
        DefaultInfo(
            files = depset([jar]),
        ),
        java_common.compile(
            ctx,
            java_toolchain = find_java_toolchain(ctx, ctx.attr._java_toolchain),
            host_javabase = find_java_runtime_toolchain(ctx, ctx.attr._host_javabase),
            output = jar,
            output_source_jar = srcjar,
            source_files = java_srcs,
            source_jars = srcjars,
            deps = [dep[JavaInfo] for dep in ctx.attr.deps],
        ),
    ]

javacc_java_library = rule(
    implementation = _javacc_java_library_impl,
    attrs = {
        "srcs": attr.label_list(
            mandatory = True,
            allow_files = [".java", ".jj"],
        ),
        "deps": attr.label_list(
            mandatory = False,
            providers = [JavaInfo],
        ),
        "_host_javabase": attr.label(
            default = "@bazel_tools//tools/jdk:current_host_java_runtime",
        ),
        "_java_toolchain": attr.label(
            default = "@bazel_tools//tools/jdk:toolchain",
        ),
        "_javacc": attr.label(
            mandatory = False,
            default = "//third_party/org_javacc/src/main:javacc",
            executable = True,
            cfg = "host",
        ),
    },
    fragments = [
        "java",
    ],
)
