echo "Please be sure you've git add --all OR git checkout !"
git diff --cached --binary > patch/git_patch.patch
echo $(pwd)/patch/git_patch.patch
