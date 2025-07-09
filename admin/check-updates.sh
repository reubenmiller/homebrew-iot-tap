#!/usr/bin/env bash
set -eou pipefail

update_formula() {
  formula_file="$1"
  repo="$2"
  tag_name=$(gh release view -R "${repo}" --json tagName --jq .tagName)
  source_url="https://github.com/${repo}/archive/refs/tags/${tag_name}.tar.gz"

  SHA256=$(curl -sSLf "${source_url}" | sha256sum - | cut -d' ' -f1)
  if [[ -z "${SHA256}" ]]
  then
    echo "Could not get sha256 of the source url. url=${source_url}" >&2
    return 1
  fi

  echo "  file   : ${formula_file}"
  echo "  tag    : ${tag_name}"
  echo "  repo   : ${repo}"
  echo "  url    : ${source_url}"
  echo "  sha256 : ${SHA256}"

  gsed -i "s|^  url .*|  url \"${source_url}\"|g" "${formula_file}"
  gsed -i "s|^  sha256 .*|  sha256 \"${SHA256}\"|g" "${formula_file}"
}

for file in Formula/*.rb
do
  echo "Checking formula for updates: ${file}" >&2
  github_repo=$(grep "^ *url" "${file}" | grep -o 'github.com/[^/]*/[^/]*' | cut -d/ -f2-)
  update_formula "${file}" "${github_repo}" || echo "Failed to check/update formula" >&2
done
