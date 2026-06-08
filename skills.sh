
#!/usr/bin/env bash
set -euo pipefail

# --- Core ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;36m'
NC='\033[0m' # No Color

function error {
    printf "${RED}%s${NC}\n" "$@"
}

function success {
    printf "${GREEN}%s${NC}\n" "$@"
}

function warn {
    printf "${YELLOW}%s${NC}\n" "$@"
}

function info {
    printf "${BLUE}%s${NC}\n" "$@"
}

info "Installing opencode skills"
npx skills init
npx skills add https://github.com/vercel-labs/skills --skill find-skills
npx skills add https://github.com/nextlevelbuilder/ui-ux-pro-max-skill --skill ui-ux-pro-max
