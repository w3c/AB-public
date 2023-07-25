#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

SOURCE_BRANCH="main"
TARGET_BRANCH="gh-pages"

# List of long-lived topic branch names to be published on github.io as a subdirectory
# Once added, branches should not be removed from here,
# because cool URLs don't change.
# (But you can stop advertising them in README.md)
# Even if the branch itself is retired,
# the built copies will continue to be served unless and until its name is removed from here.
TOPIC_BRANCHES=(
)

containsElement () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

# So we can see what we're doing
set -x

# set up the github credentials
git config --global user.email 87540780+w3cgruntbot@users.noreply.github.com
git config --global user.name w3cgruntbot
git config --global user.password $GITHUB_TOKEN

# set up env vars
REPO_URL="https://w3cbot:$GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY.git"
BRANCH=${GH_BRANCH:-$(echo $GITHUB_REF | awk 'BEGIN { FS = "/" } ; { print $3 }')}
PULL_REQUEST=${GH_EVENT_NUMBER:-false}

# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
if  [ "$PULL_REQUEST" != "false" ] || { [ "$BRANCH" != "$SOURCE_BRANCH" ] && ! containsElement "$BRANCH" "${TOPIC_BRANCHES[@]}" ; }; then
    echo "Skipping deploy; just doing a build."
    ./compile.sh
    exit 0
fi

# Clone the existing gh-pages for this repo into out/
# Create a new empty branch if gh-pages doesn't exist yet (should only happen on first deploy)
git clone $REPO_URL out
cd out
git checkout $TARGET_BRANCH || git checkout --orphan $TARGET_BRANCH
git reset --hard

if containsElement "$BRANCH" "${TOPIC_BRANCHES[@]}" ; then
    # Delete all existing contents in the topic branch directory (we will re-create them)
    mkdir -p "$BRANCH"
    cd "$BRANCH"
    find -maxdepth 1 ! -name . | xargs rm -rf
    cd ../..

    ./compile.sh "$BRANCH"
else
    # Delete all existing contents except .git and topic branches (we will re-create them)
    for i in "${TOPIC_BRANCHES[@]}"; do
            echo exclude="$exclude ! -name '$i'";
            exclude="$exclude ! -name '$i'";
    done
    eval find -maxdepth 1 ! -name .git ! -name . "$exclude" | xargs rm -rf
    cd ..

    ./compile.sh
fi

# Now let's go have some fun with the cloned repo
cd out

# If there are no changes to the compiled out (e.g. this is a README update) then just bail.
if [[ -z $(git status --porcelain) ]]; then
    echo "No changes to the output on this push; exiting."
    exit 0
fi

# Commit the "changes", i.e. the new version.
# The delta will show diffs between new and old versions.
git add -A .
git commit -m ":robot: Deploy to GitHub Pages: ${GITHUB_SHA} from branch \"${BRANCH}\""


# Now that we're all set up, we can push.
git push $REPO_URL $TARGET_BRANCH
