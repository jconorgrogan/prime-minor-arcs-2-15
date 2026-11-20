#!/bin/sh
set -eu
cd "$(dirname "$0")/../.."
target=research/dirichlet-grh
if [ "${1:-}" = "--cache" ]; then
  export MATHLIB_CACHE_DIR="${MATHLIB_CACHE_DIR:-$PWD/.cache/mathlib}"
  # Only the transitive imports of the two new files, not all of Mathlib.
  lake exe cache get $(awk '/^import / {print $2}' "$target"/*.lean | sort -u)
elif [ "$#" -ne 0 ]; then
  echo 'Usage: check.sh [--cache]' >&2
  exit 2
fi
for name in GRHZeroMass.lean PolylogConnector.lean; do
  echo "Checking $name"
  output=$(lake env lean -DwarningAsError=true "$target/$name" 2>&1) ||
      { printf '%s\n' "$output" >&2; exit 1; }
  printf '%s\n' "$output"
  printf '%s\n' "$output" | python3 -c '
import re,sys
name=sys.argv[1]
expected={
 "GRHZeroMass.lean":{"MAPGRHResearch.weightedZeroMass_le"},
 "PolylogConnector.lean":{"MinorArcsGRHStandalone.polylogPublicMAP_of_nearFar","MinorArcsGRHStandalone.GRH_square_weight_factor"}
}[name]
allowed = {"propext","Classical.choice","Quot.sound"}
checked={}
for line in sys.stdin:
    fields=re.fullmatch(r"\x27([^\x27]+)\x27 depends on axioms: \[(.*)\]\s*",line)
    if fields:
        checked[fields[1]] = {ax.strip() for ax in fields[2].split(",") if ax.strip()}
if checked.keys()!=expected or any(not ax<=allowed for ax in checked.values()):
    sys.exit(f"Wrong declarations or unexpected axioms: {checked}")
' "$name"
done
