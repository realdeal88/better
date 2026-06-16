#!/usr/bin/env bash
# Scripted demo of better for the README gif (rendered with assets/demo.tape via VHS).
# Output mirrors better's real prompt-forge behavior.
set -u

ACCENT=$'\033[38;2;157;124;240m'
GREEN=$'\033[38;2;126;200;140m'
RED=$'\033[38;2;226;130;130m'
DIM=$'\033[38;2;140;140;150m'
BOLD=$'\033[1;38;2;236;236;241m'
WHITE=$'\033[38;2;210;210;218m'
R=$'\033[0m'

p() { printf '%b\n' "$1"; sleep "${2:-0.16}"; }

sleep 0.3
p "${DIM}skill running — forging your prompt${R}" 0.5
echo
p "${ACCENT}▌${R} ${BOLD}better${R} ${DIM}·${R} ${WHITE}prompt forge${R}" 0.4
echo
p "  ${DIM}in${R}   ${RED}✗${R} ${WHITE}\"make my app faster\"${R}"
p "       ${DIM}too vague to act on — no target, no scope, no proof${R}" 0.5
echo
p "  ${DIM}out${R}  ${GREEN}✓${R} ${BOLD}forged prompt${R}"
p "       ${WHITE}Profile the home screen's render path. Find the top 3${R}"
p "       ${WHITE}re-render causes with evidence (why-did-you-render).${R}"
p "       ${WHITE}Fix each. Verify: cold-start TTI < 800ms, measured${R}"
p "       ${WHITE}5× on a release build.${R}"
echo
sleep 0.3
p "  ${ACCENT}►${R} ${BOLD}added:${R} ${WHITE}target · scope · a verifiable finish condition${R}" 0.6
echo
sleep 1.2
