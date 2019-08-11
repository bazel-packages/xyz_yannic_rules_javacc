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

dependencies = {
    "org_javacc": {
        "strip_prefix": "org_javacc-master",
        "urls": [
            "https://github.com/bazel-packages/org_javacc/archive/master.tar.gz",
        ],
    },
    # Dependency of `org_javacc`.
    "io_bazel": {
        "strip_prefix": "bazel-master",
        "urls": [
            "https://github.com/bazelbuild/bazel/archive/master.tar.gz",
        ],
    },
}
