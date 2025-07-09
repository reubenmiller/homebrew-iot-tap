#!/bin/sh
set -e

update_formula() {
    formula_file="$1"
    repo="$2"
    tag_name=$(gh release view -R "${repo}" --json tagName --jq .tagName)
    source_url="https://github.com/${repo}/archive/refs/tags/${tag_name}.tar.gz"

    SHA256=$(wget -O - "${source_url}" 2>/dev/null | sha256sum - | cut -d' ' -f1)

    echo "file   : ${formula_file}"
    echo "tag    : ${tag_name}"
    echo "repo   : ${repo}"
    echo "url    : ${source_url}"
    echo "sha256 : ${SHA256}"

    gsed -i "s|^  url .*|  url \"${source_url}\"|g" "${formula_file}"
    gsed -i "s|^  sha256 .*|  sha256 \"${SHA256}\"|g" "${formula_file}"
}

for file in Formula/*.rb; do
    echo "Checking formula for updates: ${file}" >&2
    github_repo=$(grep "^ *url" "${file}" | grep -o 'github.com/[^/]*/[^/]*' | cut -d/ -f2-)
    if ! update_formula "${file}" "${github_repo}"; then
        echo "Failed to check/update formula" >&2
    fi
done
