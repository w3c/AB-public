#!/bin/bash

PUBLICATION_URL="https://w3c.github.io/ab-public/"

# files to be build by bikeshet as a spec.
BUILD_TARGETS=(
	"Vision/Vision.bs"
	"Glossary/Glossary.bs"
	"council-templates/council-report-template.bs"
	"council-templates/council-supplemental-report-template.bs"
)

# files or directories to be copied as is into the output.
# To be used either for supporting files (e.g. images)
# or for pre-built documents (supporting files, dated snapshots…)
COPY_TARGETS=(
	"Vision/AC-2021"
	"README.md"
)

# So we can see what we're doing
set -x

# Exit with nonzero exit code if anything fails
set -e

for t in ${BUILD_TARGETS[@]}; do
	# Run bikeshed.  If there are errors, exit with a non-zero code
	# Include a warning in the status for topic branches
	if [ $1 ] ; then
		NAKED_NAME=${t%.bs}
		bikeshed --print=plain -f spec $t "${NAKED_NAME}.html" \
			--md-status="w3c/ED" \
			--md-ED="${PUBLICATION_URL}$1/${NAKED_NAME##*/}" \
			--md-status-text="<details class=annoying-warning open><summary>This is not the latest Editor’s Draft.</summary>\
			<p>This is the “$1” topic branch; make sure this is indeed the one you’re looking for.\
			If not, the current Editor’s Draft can be found at\
			<a href='${PUBLICATION_URL}${NAKED_NAME##*/}'>${PUBLICATION_URL}${NAKED_NAME##*/}</a>.<br>\
			(The <a href=#sotd>Status of this document</a> section may have information about the purpose of this branch.)</details>"
	else
		bikeshed --print=plain -f spec $t
	fi

done

# Bikeshed the DoCs as well
for i in issues-*.txt; do
	if [ -f $i ]; then
		bikeshed --print=plain -f issues-list $i
	fi
done

# The out/$1 directory needs to contain everything needed
# to publish the HTML version of the spec.
# Copy things there if the directory exists.
# Only copy the actual Process if we're on a topic branch,
# and everything else too (DoCs, snapshots) if we're on the main branch.

if [ -d out/$1 ]; then
	for t in ${COPY_TARGETS[@]}; do
		cp -r $t out/$1/
	done
	for i in issues-*.html; do
		if [ -f $i ]; then
			cp -r $i out/$1/
		fi
	done
	for t in ${BUILD_TARGETS[@]}; do
		cp "${t%.bs}.html" out/$1/
	done
fi
